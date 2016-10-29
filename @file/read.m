function contents = read(self)              
%% read() - read any ascii file line by line
% return contents as cell array of strings
% each line is saved as a row in a nx1 cell array
    fid = self.open();
    % loop till end of file or flag
    contents = []; cnt = 1;
    while ~feof(fid)
        % read line
        contents{cnt,1} = fgetl(fid);
        cnt = cnt+1;
    end
    % close file & report status
    status = fclose(fid);
    if status == 0; fprintf('Read successful. \n');
    else fprintf('Not successful. Damn. \n');
    end
end