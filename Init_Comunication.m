%% init comunication
 Kuka=tcpip('192.168.1.100',7000); % init comunication
 fopen(Kuka);
 
AXIS_ACT=[0;0;0;13;0;0;10;36;65;88;73;83;95;65;67;84];
fwrite(Kuka,AXIS_ACT);
joint_message=fread(Kuka,Kuka.BytesAvaliable);