function update_kct_gui(Joints)   
    global kctshowbound
    global kctdrivespace

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

    set(handles.slider1,'Value',kcttempposition(2,1));
    kctdisprobot(Joints, 100, kctcamdata);
% Bound display    
    if kctshowbound
        kctdrivegui_bound(kctdrivespace, 100);
        return
    end
    drawnow()
end