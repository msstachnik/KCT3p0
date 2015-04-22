/**
%    KCTCLIENTMEX - Initialize the MATLAB client for KUKA robot comunication MEX file
%
%    The function initializes a TCP/IP connection on the specified URL and port
%    in order to start the comunication with the KUKA robot's server.
%   
%    Usage: t = kctclientmex(str_address)
%
%    Arguments:
%           str_address = server PC's IP address (string format).
%    Return:
%           t = handler for communication with the KUKA robot
%
%    See also: KCTSENDDATAMEX, KCTCLOSECLIENTMEX, KCTRECDATAMEX
%

%    Copyright (c) 2009 Stefano Scheggi
%    Department of Information Engineering
%    University of Siena
%
%    This file is part of KCT (Kuka Control Toolbox).
%
%    KCT is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    KCT is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with KCT. If not, see <http://www.gnu.org/licenses/>.
**/

#ifdef _WIN32
    #include <windows.h>
    #include <winsock.h>
#else
    #define INVALID_SOCKET -1
    #define SOCKET_ERROR -1
    #define closesocket close
    #include <sys/types.h>
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <arpa/inet.h>
    #include <netdb.h>
        
#endif

#include <stdio.h>
#include <string.h>
#include <mex.h> //MATLAB API

#pragma comment(lib, "libmx.lib")
#pragma comment(lib, "libmat.lib")
#pragma comment(lib, "libmex.lib")
#pragma comment(lib, "wsock32.lib")
// ->>>> mex kctclient.c wsock32.lib

#define PROTOPORT 2999 /* default protocol port number */
    
mxArray *mymatrix;

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{    
/* 
 * variable declarations here 
 */
    #ifdef _WIN32
      WORD wVersionRequested = MAKEWORD(1,1);       // Stuff for WSA functions
      WSADATA wsaData;                              // Stuff for WSA functions
    #endif
    
    int buflen, status;
    char *host_to_connect;
    unsigned int         client_s;        // Client socket descriptor
    struct sockaddr_in   server_addr;     // Server Internet address
    int iError = 0;
    double *output_val;
     
    /* check for proper number of arguments */
    if(nrhs!=1) 
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs",
                          "One input required.");
    if(nlhs!=1) 
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs",
                          "One output required.");
    /* input must be a string */
    if ( mxIsChar(prhs[0]) != 1)
         mexErrMsgTxt("Input must be a string.");
    /* input must be a row vector */
    if (mxGetM(prhs[0])!=1)
        mexErrMsgTxt("Input must be a row vector.");
       
/* 
 * code here 
 */ 
    /* get the length of the input string */
    buflen = (mxGetM(prhs[0]) * mxGetN(prhs[0])) + 1;
    /* allocate memory for input and output strings */
    host_to_connect = mxCalloc(buflen, sizeof(char));
    status = mxGetString(prhs[0], host_to_connect, buflen);
    //plhs[0] = mxCreateString(host_to_connect);
    /* Set the output */
    plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL); 
    output_val = mxGetPr(plhs[0]);  
    output_val[0] = -1;
   
    #ifdef _WIN32
      // This stuff initializes winsock
      iError  = WSAStartup(wVersionRequested, &wsaData);
    #endif

    client_s = socket(AF_INET, SOCK_STREAM, 0);

    if(client_s == INVALID_SOCKET || iError == 1){
        mexPrintf("Invalid Socket! \n");
        #ifdef _WIN32
            WSACleanup();
        #endif
        return;
    }
    
    server_addr.sin_family = AF_INET;                 // Address family to use
    server_addr.sin_port = htons(PROTOPORT);           // Port num to use
    server_addr.sin_addr.s_addr = inet_addr(host_to_connect); // IP address to use
    
    if (connect(client_s, (struct sockaddr *)&server_addr, sizeof(server_addr)) == SOCKET_ERROR){
        mexPrintf("Connection Refused! \n");
        #ifdef _WIN32
            WSACleanup();
        #endif
        return;
    }
    
    // Everything ok
    output_val[0] = client_s;
    mexPrintf("Connected to '%s' on port '%d'.\n", host_to_connect,PROTOPORT);
    mexPrintf("TCPIP handle kctclientmex '%d' \n", client_s); 
    
    /* Set Global IP var */
    mymatrix = mxCreateDoubleMatrix(1,1,mxREAL);
    mxGetPr(mymatrix)[0] = -1;//client_s;
    mexPutVariable("global", "kctipvar", mymatrix);  
}
