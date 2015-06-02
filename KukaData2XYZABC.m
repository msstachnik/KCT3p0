function Joints = KukaData2XYZABC(MessData)
% funkcja s�u�aca do konwersji wiadomo�ci tcpip na 6 pozycji X Y Z A B C.

Char_Data = char(MessData(:)'); % konwersja na string

ends_of_value = strfind(Char_Data,',') - 1; % znalezienie wa�nych znacznik�w ko�ca danyych - przecink�w

Joints = ones(1,6); %inicjalizacja tablicy
for i=1:6
    Joints(i) = getSigleValue(Char_Data, ends_of_value, i); % 6-krotne wywo�anie funkcji pobierajacej warto�� z stringu
end





function Y = getSigleValue(Char_Data, ends_of_value, Number)
Position = {'X','Y','Z','A','B','C'};
Y_start_char = strfind(Char_Data, Position{Number}) + 2;
if length(ends_of_value) >= Number                                  % pierwszy warunek czy d�ugos� wiadomo�ci jest ok
    Y_end_char = ends_of_value(Number);
    
    if isempty(Y_start_char) || isempty(Y_end_char)                   %drugi warunek czy znalaz�o wszystkie jointy
        Y = NaN;
    elseif Y_start_char <= length(Char_Data)                          %trzeci warunek je�li A1 jest na ko�cu wiadomosci
        Y = str2double(Char_Data(Y_start_char:Y_end_char));
    else
        Y = NaN;
    end
    
else
    Y = NaN;
end


