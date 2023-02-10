function [ CommandArray ] = InputGcode(filename, PathName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
FileName=strcat(PathName,filename);

fid=fopen(FileName);
tline = fgetl(fid);

% Initialize Variables
ctr=1;
endFlag=0; %0=false, 1=true
xTemp=NaN;
yTemp=NaN;
zTemp=NaN;
eTemp=NaN;
fTemp=NaN;
X=NaN;
Y=NaN;
Z=NaN;
E=NaN;
F=NaN;
endstr=';-- END GCODE --';
ReadFlag = 0;
MoveFlag = 0;
while ischar(tline)
    Line=tline;
    if strcmp(Line,'')
        tline = fgetl(fid);
        Line = tline;
        %emptyline = 'emptyline';
    end
    if ~isempty(Line)
        if strcmp(Line,endstr)
            endFlag=1;
            %endfound = 'endfound'
        end
        if strcmp(Line(1),';')
            tline = fgetl(fid);
            Line=tline;
            %commentline = 'commentline';            
        end
    end
    if ~endFlag
        for i=1:size(Line,2)
            if (strcmp(Line(i),'G') && strcmp(Line(i+1),'1')) || (strcmp(Line(i),'G') && strcmp(Line(i+1),'0'))
                ReadFlag = 1;
            end
            if strcmp(Line(i),'X') || strcmp(Line(i),'Y')% || strcmp(Line(i),'Z')
                MoveFlag = 1;
            end
        end
        if ReadFlag == 1;
            for j=1:size(Line,2)
                if strcmp(Line(j),'X');
                    xTemp = str2double(strtok(Line(j+1:end)));
                end
                if strcmp(Line(j),'Y');
                    yTemp = str2double(strtok(Line(j+1:end)));
                end
                if strcmp(Line(j),'Z');
                    zTemp = str2double(strtok(Line(j+1:end)));
                end
                if strcmp(Line(j),'E');
                    eTemp = str2double(strtok(Line(j+1:end)));
                end
                if strcmp(Line(j),'F');
                    fTemp = str2double(strtok(Line(j+1:end)));
                end
            end
            if MoveFlag == 1;
                X(ctr)=xTemp;
                Y(ctr)=yTemp;
                Z(ctr)=zTemp;
                E(ctr)=eTemp;
                F(ctr)=fTemp;
                ctr=ctr+1;
             end
        end
    end
    tline = fgetl(fid);
    ReadFlag = 0;
    MoveFlag = 0;
end
fclose(fid);
CommandArray = [X;Y;Z;E;F];
clear xTemp yTemp zTemp eTemp token tline i j fid endstr endFlag ctr Line ans
end

