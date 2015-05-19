function update_kct_gui(Joints)   
    global kctshowbound
    global kcttempposition
    global kctdrivespace
    
    %camera
    kctcampos = campos();
    kctcamtarget = camtarget();
    kctcamup = camup();
    kctcamva = camva();
    kctcamproj = camproj();
    kctcamdata = struct('CamPosition',kctcampos,'CamTarget',...
                 kctcamtarget,'CamUp',kctcamup,'CamVa',kctcamva,...
                 'CamProj',kctcamproj);
    clf
% Robot display
    
   kcttempposition(2,:) = Joints;   %update global variable of actual position
   
    kctdisprobot(Joints, 100, kctcamdata);  
% Bound display    
    if kctshowbound
        kctdrivegui_bound(kctdrivespace, 100);
        return
    end
    drawnow()
end