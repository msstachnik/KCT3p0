/**
%    KCTSENDDATAMEX - Send data to the kctserver
%
%    The function sends data to the kctserver
%   
%    Usage: kctsenddata(str_data)
%
%    Arguments:
%           str_data = data to send (string format).
%
%    See also: KCTCLIENTMEX, KCTCLOSECLIENTMEX, KCTRECDATAMEX
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
    char                *data_to_send;
    int                  buflen, status;
    
    /* check for proper number of arguments */
    if(nrhs!=1) 
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs",
                          "One input required.");
    if(nlhs!=0) 
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs",
                          "No output required.");
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
    data_to_send = mxCalloc(buflen, sizeof(char));
    status = mxGetString(prhs[0], data_to_send, buflen);
    
    /* get Global IP var */
    mymatrix = mexGetVariable("global", "kctipvar");
    client_s = (int)mxGetPr(mymatrix)[0];
    //mexPrintf("TCPIP handle kctreadstatemex '%d' \n", client_s);

    // Send to the server using the client socket
    send(client_s, data_to_send, (strlen(data_to_send)), 0);
    //mexPrintf("Sending data %s \n", data_to_send);
}
