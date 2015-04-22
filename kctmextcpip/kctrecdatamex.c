
/**
%    KCTRECDATAMEX - Receive data from the kctserver
%
%    The function reads the communication buffer receiving data from the kctserver
%   
%    Usage: [bytesRec, data] = kctrecdatamex()
%
%    Return:
%           bytesRec = number of bytes received
%           data     = data received
%
%    See also: KCTCLIENTMEX, KCTCLOSECLIENTMEX, KCTSENDDATAMEX
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
    
    unsigned int         client_s;        // Client socket descriptor
    char in_buf[400];
    int byteReceived = 0;
    double *output_val;
    
    /* check for proper number of arguments */
    if(nrhs!=0) 
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs",
                          "No input required.");
    if(nlhs!=2) 
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs",
                          "Two outputs required.");
       
/* 
 * code here 
 */     
    /* get Global IP var */
    mymatrix = mexGetVariable("global", "kctipvar");
    client_s = (int)mxGetPr(mymatrix)[0];
    //mexPrintf("TCPIP handle kctreadstatemex '%d' \n", client_s);
   
    // Receive from the server using the client socket
    byteReceived = recv(client_s, in_buf, sizeof(in_buf), 0);
    
    plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL); 
    output_val = mxGetPr(plhs[0]);  
    output_val[0] = byteReceived;
    plhs[1] = mxCreateString(in_buf);
        
    //mexPrintf("Received bytes '%d' \n", byteReceived);
    //mexPrintf("Received from server... data = '%s' \n", in_buf);
}
