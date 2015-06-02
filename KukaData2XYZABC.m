function Joints = KukaData2XYZABC(MessData)
% funkcja s³u¿aca do konwersji wiadomoœci tcpip na 6 pozycji X Y Z A B C.

Char_Data = char(MessData(:)'); % konwersja na string

ends_of_value = strfind(Char_Data,',') - 1; % znalezienie wa¿nych znaczników koñca danyych - przecinków

Joints = ones(1,6); %inicjalizacja tablicy
for i=1:6
    Joints(i) = getSigleValue(Char_Data, ends_of_value, i); % 6-krotne wywo³anie funkcji pobierajacej wartoœæ z stringu
end





function Y = getSigleValue(Char_Data, ends_of_value, Number)
Position = {'X','Y','Z','A','B','C'};
Y_start_char = strfind(Char_Data, Position{Number}) + 2;
if length(ends_of_value) >= Number                                  % pierwszy warunek czy d³ugosæ wiadomoœci jest ok
    Y_end_char = ends_of_value(Number);
    
    if isempty(Y_start_char) || isempty(Y_end_char)                   %drugi warunek czy znalaz³o wszystkie jointy
        Y = NaN;
    elseif Y_start_char <= length(Char_Data)                          %trzeci warunek jeœli A1 jest na koñcu wiadomosci
        Y = str2double(Char_Data(Y_start_char:Y_end_char));
    else
        Y = NaN;
    end
    
else
    Y = NaN;
end


