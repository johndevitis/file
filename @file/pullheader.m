function header = pullheader(self,in, delim, RC, rc)
%% pullheader
% Pull header strings from file
% in - data
% delim - String indicating the delimiter
% RC - String indicating if row or column is header. 
%       'R' = row; 'C' = column
% rc - Double. The index of the header row or column
%
% out - array of strings, each containing header label
%
% Null input results in reading the file contents, and returning the
% strings in the first row
%
% author: John Braley
% create date: 31-Aug-2016 09:43:56


%% Error screen entry
if nargin<2 || isempty(in); % Null entry
 in = self.read(); end % Read file data
if nargin < 3 || isempty(delim); delim = 'c'; end
if nargin < 4 || isempty(RC); RC = 'R'; end
if nargin < 5 || isempty(rc); rc = 1; end

% Seperate header from file contents
switch RC
    case {'R';'r';'row'} 
        header = strsplit(in{rc},delim); % Split header row string by delimiter
    case {'C';'c';'col';'column'}
        for ii = 1:size(in,1)
            row = strsplit(in{ii},delim); % Split each row string by delimiter
            header(ii) = row(rc); % save header row value
        end        
end

end
