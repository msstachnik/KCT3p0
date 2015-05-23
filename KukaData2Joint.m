function Joints = KukaData2Joint(MessData)

Char_Data = char(MessData(:)');

ends_of_value = strfind(Char_Data,',') - 1;

Joints = ones(1,6);
for i=1:6
    Joints(i) = getSigleValue(Char_Data, ends_of_value, i);
end





function Y = getSigleValue(Char_Data, ends_of_value, Number)

Y_str_char = strfind(Char_Data, strcat('A',num2str(Number))) + 3;
if length(ends_of_value) >= Number                                  % pierwszy warunek czy d³ugosæ wiadomoœci jest ok
    Y_end_char = ends_of_value(Number);
    
    if isempty(Y_str_char) || isempty(Y_end_char)                   %drugi warunek czy znalaz³o wszystkie jointy
        Y = NaN;
    elseif Y_str_char <= length(Char_Data)                          %trzeci warunek jeœli A1 jest na koñcu wiadomosci
        Y = str2double(Char_Data(Y_str_char:Y_end_char));
    else
        Y = NaN;
    end
    
else
    Y = NaN;
end


