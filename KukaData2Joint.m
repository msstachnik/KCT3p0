function Joints = KukaData2Joint(MessData)

Char_Data = char(MessData(:)'); % to be sure to get data as char

ends_of_value = strfind(Char_Data,',') - 1; % find ',' - end of values

Joints = ones(1,6);
for i=1:6
    Joints(i) = getSigleValue(Char_Data, ends_of_value, i); % get six times values
end



end

function Y = getSigleValue(Char_Data, ends_of_value, Number) %function to get single value

Y_str_char = strfind(Char_Data, strcat('A',num2str(Number))) + 3;   %start char no
Y_end_char = ends_of_value(Number);                                 %end char no
Y = str2double(Char_Data(Y_str_char:Y_end_char));                   %get char


end