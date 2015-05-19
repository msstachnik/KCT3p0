%% init comunication
 Kuka=tcpip('192.168.1.100',7000); % init comunication
 fopen(Kuka);
 joint_history = []; % use to remmember joint history
 
 %% use this in loop
AXIS_ACT=[0;0;0;13;0;0;10;36;65;88;73;83;95;65;67;84];
fwrite(Kuka,AXIS_ACT); % ask for data
joint_message=fread(Kuka,Kuka.BytesAvaliable); %get data from message
joint = KukaData2Joint(joint_message); % convert from message data to joint vector
joint_history = [joint_history; joint]; % add to joint history
update_kct_gui(joint);