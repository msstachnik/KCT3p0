#include <iostream>
#include <stdlib.h>
#include <cstdlib>
#include <winsock.h>
#include <windows.h>
#include <stdio.h>
#include <conio.h>
#include <fstream>
#include <string>
#include <vector>
#include <process.h>

using namespace std;

vector<string> buffer_read;
int index_write = 0;

typedef struct tag_parametri{ // create data structure that manages info inside the thread
char *com;
int * data_1;
SOCKET client_1;
} parametri;


void th_fun(void* ); // Thread function

static volatile int semaf,block;
char position[1300];
 
int main(){
     char msg_rcv[1300];    
     char command[100];
     char buf_str[100];
     int SleepMode=0;
     int errore_th;
     int i, stop, cicle, time;
     int error_vet[6];

     int  buff  =  sizeof(struct  sockaddr);
     SOCKET  server, server1,  client, client1;
     SOCKADDR_IN  server_addr, client_addr, server_addr1, client_addr1;
     WSADATA  wsInfo;
     DWORD  sockInfo;
     parametri param;
     param.com=command;
     int  data,data1;
     param.data_1 = &data1; 
     
     /* Load XML file */
     FILE *myfile;
     char ch, * msg_send, FileName[256]="ExternalData.xml";
     int indice, fileDim = 0;

     if(( myfile = fopen(FileName , "rb")) !=NULL){
       // Go to the end of file
       fseek(myfile, 0, SEEK_END);
       // Read the position
       fileDim = ftell(myfile);
       // Allocate buffer dimension
       msg_send = (char*) malloc(sizeof(char) * fileDim+1);
       // Go to the begin of the file
       fseek(myfile, 0, SEEK_SET);
       // Copy all content of the file in the buffer
       fread(msg_send, fileDim, 1, myfile);
       // Close the file
       fclose(myfile);
     }
     else{ 
       cout << "File input not found! Please control that ExternalData.xml is in same kctserver fold and retry.\n\n";
     } 
     
     /* Create socket */
     sockInfo = MAKEWORD(2,0);         
     error_vet[1] = WSAStartup(sockInfo,&wsInfo);
     if (error_vet[1]==0)
       cout<<"Library initialization done\n\n";
     else
       cout<<"Library initialization failed\n\n";

     server = socket(PF_INET,SOCK_STREAM,0);           //  Socket setting
     server_addr.sin_family = PF_INET;                 //  Protocol
     server_addr.sin_port = htons(6008);               //  Port
     server_addr.sin_addr.s_addr = INADDR_ANY;         //  IP address

     server1  =  socket(PF_INET,SOCK_STREAM,0);          //  Socket setting
     server_addr1.sin_family  =  PF_INET;                //  Protocol
     server_addr1.sin_port  =  htons(2999);              //  2° client port
     server_addr1.sin_addr.s_addr  =  INADDR_ANY;        //  IP address

     error_vet[2] = bind(server,(struct sockaddr*)&server_addr,sizeof(struct sockaddr_in));
     error_vet[3] = listen(server,1);
     error_vet[4] = bind(server1,(struct sockaddr*)&server_addr1,sizeof(struct sockaddr_in));
     error_vet[5] = listen(server1,1);

     if (error_vet[2]==0)
       cout<<"Binding PC socket:  OK\n\n";
     else
       cout<<"Binding PC socket: error\n\n";

     if (error_vet[4]==0)
       cout<<"Binding KUKA socket: OK\n\n";
     else
       cout<<"Binding KUKA socket: error\n\n";
              
     if (error_vet[5]==0)
       cout<<"Listening for 2999 PC socket ...\n\n";
     else
       cout<<"Listening for 2999 PC socket error \n\n";

     client1 = accept(server1,(struct  sockaddr*)&client_addr1,&buff);
     cout<<"PC client connection DONE \n\n";
     param.client_1 = client1; // Pass the socket to the thread

     /* Start the thread */
     errore_th = _beginthread(th_fun,0,(void*)&param);
     
     if(errore_th==-1) 
       exit(1); 
     
     while (true){
       if (error_vet[3]==0)
	 cout<<"Listening for KUKA 6008 socket...\n\n";
       else
         cout<<"Listening for KUKA 6008 socket...\n\n";
              
       stop = 0;
       client = accept(server,(struct  sockaddr*)& client_addr,  &buff);
       cout<<"KUKA client connection DONE \n\n\n";
       cout <<"System READY\n";
       cicle = 0;
       time = 0;       
       char* ipoc_rec_i,*ipoc_send_i,*com_send_i,*com_rec_i;
       string rec,sen;
       char *ssend;
       data =- 1;
       int errore=0;
       semaf = 0;
       block = 0;

       while(errore==0){
	 errore=WSAGetLastError();
         data = recv(client,msg_rcv,sizeof(msg_rcv),0); //blocking
         strcpy(position,msg_rcv);
         if(data>0 && errore==0){
	   if (index_write < buffer_read.size()){      
	     if((buffer_read.at(index_write).compare(0,2,"<R"))==0){ 
	       com_rec_i = strstr(buffer_read.at(index_write).c_str(),"<RKorr");
               com_send_i = strstr(msg_send,"<RKorr");
               strncpy(com_send_i,com_rec_i,buffer_read.at(index_write).size());
               index_write ++;
             }
             else if((buffer_read.at(index_write).compare(0,2,"<A"))==0){
	       com_rec_i = strstr(buffer_read.at(index_write).c_str(),"<AKorr");
               com_send_i = strstr(msg_send,"<AKorr");
               strncpy(com_send_i,com_rec_i,buffer_read.at(index_write).size());
               index_write ++;
             }
             else if((buffer_read.at(index_write).compare(0,6,"<ask/>"))==0){ 
	       send(client1,msg_rcv,400,0);
	       index_write ++;
             }
	   }          
	   ipoc_rec_i = strstr(msg_rcv,  "<IPOC>")+6;
	   ipoc_send_i = strstr(msg_send,"<IPOC>")+6;
	   strncpy(ipoc_send_i,ipoc_rec_i,10);
	   send(client,msg_send,fileDim,0);
           data =- 1;
         }
       }
       cout<<"Communication ERROR n: "<<errore<<"\n\n";
       cout<<"Program will RESTART, please repeat client connection.\n\n";
       closesocket(client);
       errore = 0;
     }   
     closesocket(client1);
     closesocket(server);
     closesocket(server1);
     WSACleanup();
     system("pause");
     _endthread();
     return 0;
}

/* Thread function that receives data from client */
void th_fun(void* p){ 
  // Container for reading data
  string temp_string = "";
  parametri* p_th =(parametri*)p;
  *(p_th->data_1) = -1;
  while (true){           
    *(p_th->data_1) = recv((p_th->client_1),(p_th->com),100,0);
    temp_string.append( p_th->com, 0, *(p_th->data_1) );
    string::size_type loc = temp_string.find( "/>", 0 );
    while( loc != string::npos ) {
      buffer_read.push_back(temp_string.substr(0, loc+2));
      temp_string = temp_string.substr(loc+2);
      loc = temp_string.find( "/>", 0 );
    } 
  }      
}





