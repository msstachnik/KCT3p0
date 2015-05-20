function Joints = KukaData2Joint(MessData)

Char_Data = char(MessData(:)');

ends_of_value = strfind(Char_Data,',') - 1;

Joints = ones(1,6);
for i=1:6
    Joints(i) = getSigleValue(Char_Data, ends_of_value, i);
end



end

function Y = getSigleValue(Char_Data, ends_of_value, Number)

Y_str_char = strfind(Char_Data, strcat('A',num2str(Number))) + 3;
Y_end_char = ends_of_value(Number);
Y = str2double(Char_Data(Y_str_char:Y_end_char));


end