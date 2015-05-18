t

   TCPIP Object : TCPIP-127.0.0.1

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         127.0.0.1
      Terminator:         'LF'
      NetworkRole:        server

   Communication State 
      Status:             open
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     0
      ValuesReceived:     17
      ValuesSent:         0
 

fclose(t)
t

   TCPIP Object : TCPIP-localhost

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         localhost
      Terminator:         'LF'
      NetworkRole:        server

   Communication State 
      Status:             closed
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     0
      ValuesReceived:     17
      ValuesSent:         0
 

fopen(t)
t

   TCPIP Object : TCPIP-127.0.0.1

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         127.0.0.1
      Terminator:         'LF'
      NetworkRole:        server

   Communication State 
      Status:             open
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     17
      ValuesReceived:     0
      ValuesSent:         0
 

d=fread(t)
Warning: Unsuccessful read:  The specified amount of data was not returned
within the Timeout period. 

d =

     0
     0
     0
    13
     0
     0
    10
    36
    80
    79
    83
    95
    65
    67
    84
    46
   120

char(d')

ans =

   
  
$POS_ACT.x

help tcpip
 tcpip Construct tcpip client or server object.
 
    OBJ = tcpip('RHOST') constructs a tcpip client or server object,
    OBJ, associated with remote host, RHOST, and the default remote
    port value of 80.
 
    In order to communicate with the instrument, the object, OBJ, must
    be connected to RHOST with the FOPEN function.
 
    OBJ = tcpip('RHOST', RPORT) constructs a tcpip object, OBJ,
    associated with remote host, RHOST, and remote port value, RPORT.
 
    By default, the tcpip client support is selected. When the tcpip
    object is constructed, the object's Status property is closed. Once
    the object is connected to the host with the FOPEN function, the
    Status property is configured to open.
 
    OBJ = tcpip(..., RPORT, 'P1',V1,'P2',V2,...) construct a tcpip
    object with the specified property values. If an invalid property
    name or property value is specified the object will not be created.
 
    Note that the property value pairs can be in any format supported
    by the SET function, i.e., param-value string pairs, structures,
    and param-value cell array pairs.
 
    The default local host in multi-homed hosts is the systems default.
    LocalPort defaults to a value of [], and it causes any free local
    port to be picked up as the local port. The LocalPort property is
    updated when FOPEN is issued.
 
    A property value pair of 'NetworkRole', 'server' will cause tcpip
    to block and wait for a connection from a single remote client
    matching the 'RHOST' when FOPEN is called.  In a trusted
    environment, the remote host may be set to the wild card address of
    '0.0.0.0' to accept connections from any single client. While a
    valid connection is open, the tcpip RemoteHost will be set to the
    address of the client that is connected.
 
    At any time you can view a complete listing of tcpip functions and
    properties with the INSTRHELP function, i.e., instrhelp tcpip.
 
    Client Example:
        echotcpip('on',4012) 
        t = tcpip('localhost',4012); 
        fopen(t)
        fwrite(t,65:74) 
        A = fread(t, 10); 
        fclose(t);
        delete(t)
        echotcpip('off')
 
    Server Example:
        t=tcpip('localhost', 4012, 'NetworkRole', 'server');
        fopen(t);  % this will block until a connection is received.
 
    See also echotcpip, icinterface/fopen, instrument/propinfo,
    instrhelp, sendmail, udp, urlread, urlwrite.
 

    Reference page in Help browser
       doc tcpip

t2 = tcpip('192.168.1.100',7000);
t2

   TCPIP Object : TCPIP-192.168.1.100

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         192.168.1.100
      Terminator:         'LF'
      NetworkRole:        client

   Communication State 
      Status:             closed
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     0
      ValuesReceived:     0
      ValuesSent:         0
 

fopen(t2)
t2

   TCPIP Object : TCPIP-192.168.1.100

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         192.168.1.100
      Terminator:         'LF'
      NetworkRole:        client

   Communication State 
      Status:             open
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     0
      ValuesReceived:     0
      ValuesSent:         0
 

fwrite(t2,d)
t2

   TCPIP Object : TCPIP-192.168.1.100

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         192.168.1.100
      Terminator:         'LF'
      NetworkRole:        client

   Communication State 
      Status:             open
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     20
      ValuesReceived:     0
      ValuesSent:         17
 

d2=fread(t2,20)

d2 =

     0
     0
     0
    16
     0
     0
    10
    50
    56
    52
    46
    57
    57
    52
    57
    54
    53
     0
     1
     1

char(d2')

ans =

     
284.994965 

t2

   TCPIP Object : TCPIP-192.168.1.100

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         192.168.1.100
      Terminator:         'LF'
      NetworkRole:        client

   Communication State 
      Status:             open
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     0
      ValuesReceived:     20
      ValuesSent:         17
 

d

d =

     0
     0
     0
    13
     0
     0
    10
    36
    80
    79
    83
    95
    65
    67
    84
    46
   120

d(end)=121

d =

     0
     0
     0
    13
     0
     0
    10
    36
    80
    79
    83
    95
    65
    67
    84
    46
   121

fwrite(t2,d)
t2

   TCPIP Object : TCPIP-192.168.1.100

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         192.168.1.100
      Terminator:         'LF'
      NetworkRole:        client

   Communication State 
      Status:             open
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     21
      ValuesReceived:     20
      ValuesSent:         34
 

d2=fread(t2,21)

d2 =

     0
     0
     0
    17
     0
     0
    11
    45
    54
    57
    52
    46
    51
    57
    52
    54
    53
    51
     0
     1
     1

zmienna = char(d2(8:7+d2(7)))

zmienna =

-
6
9
4
.
3
9
4
6
5
3

zmienna = char(d2(8:7+d2(7))')

zmienna =

-694.394653

mss=d

mss =

     0
     0
     0
    13
     0
     0
    10
    36
    80
    79
    83
    95
    65
    67
    84
    46
   121

mss'

ans =

  Columns 1 through 13

     0     0     0    13     0     0    10    36    80    79    83    95    65

  Columns 14 through 17

    67    84    46   121

mss=msg(1:end-2)
Undefined function or variable 'msg'.
 
mss=mss(1:end-2)

mss =

     0
     0
     0
    13
     0
     0
    10
    36
    80
    79
    83
    95
    65
    67
    84

char(mss')

ans =

   
  
$POS_ACT

fwrite(t2,mss)
t2

   TCPIP Object : TCPIP-192.168.1.100

   Communication Settings 
      RemotePort:         7000
      RemoteHost:         192.168.1.100
      Terminator:         'LF'
      NetworkRole:        client

   Communication State 
      Status:             open
      RecordStatus:       off

   Read/Write State  
      TransferStatus:     idle
      BytesAvailable:     164
      ValuesReceived:     41
      ValuesSent:         49
 

t2.BytesAvailable

ans =

   164

d2=fread(t2,t2.BytesAvailable)

d2 =

     0
     0
     0
   160
     0
     0
   154
   123
    69
    54
    80
    79
    83
    58
    32
    88
    32
    50
    56
    52
    46
    57
    57
    52
    57
    54
    53
    44
    32
    89
    32
    45
    54
    57
    52
    46
    51
    57
    52
    54
    53
    51
    44
    32
    90
    32
    52
    49
    46
    50
    52
    55
    56
    50
    57
    52
    44
    32
    65
    32
    49
    51
    49
    46
    52
    51
    48
    51
    52
    52
    44
    32
    66
    32
    45
    48
    46
    48
    49
    57
    49
    53
    52
    51
    49
    57
    53
    44
    32
    67
    32
    49
    55
    57
    46
    57
    57
    50
    49
    49
    49
    44
    32
    83
    32
    50
    44
    32
    84
    32
    49
    48
    44
    32
    69
    49
    32
    48
    46
    48
    44
    32
    69
    50
    32
    48
    46
    48
    44
    32
    69
    51
    32
    48
    46
    48
    44
    32
    69
    52
    32
    48
    46
    48
    44
    32
    69
    53
    32
    48
    46
    48
    44
    32
    69
    54
    32
    48
    46
    48
   125
     0
     1
     1

char(d2')

ans =

      ?{E6POS: X 284.994965, Y -694.394653, Z 41.2478294, A 131.430344, B -0.0191543195, C 179.992111, S 2, T 10, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0} 

help diary
 diary Save text of MATLAB session.
    diary FILENAME causes a copy of all subsequent command window input
    and most of the resulting command window output to be appended to the
    named file.  If no file is specified, the file 'diary' is used.
 
    diary OFF suspends it. 
    diary ON turns it back on.
    diary, by itself, toggles the diary state.
 
    Use the functional form of diary, such as diary('file'),
    when the file name is stored in a string.
 
    See also save.

    Reference page in Help browser
       doc diary

