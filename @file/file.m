classdef file < matlab.mixin.SetGet
%% class file
%
% fileparts wrapper and error screening super class. 
%
% * class can be constructed on load w/ fullpath or using default temp loc
%
% author: jdv
% create date: 22-Jul-2016 08:57:19

%% object properties 
	properties
        path = 'C:\Temp' % root path  
        name = 'foo'     % class name
        ext = '.txt'     % text extension
    end
    
%% dependent properties
	properties (Dependent)
        
        fullname % full file path/name.ext generated 
    end

%% developer properties
	properties (Access = private)
    end
    
%% dynamic methods
	methods
        
    %% constructor
		function self = file(fullpath)
            if nargin > 0 && ~isempty(fullpath)
                [self.path,self.name,self.ext] = fileparts(fullpath);
            end
        end
        
%     %% ordinary
%         function chk_name(self,disp_chk)
%         %% chk_name
%         % * checks for an empty object name, throws an error if found. 
%         % * also checks for hidden path or extension info in name
%         % * use disp_chk = 1 to display current file path to user, else
%         % function only error screens null name
%         % * at end of fcn chk_name checks for missing ext field. this is so
%         % the nested filename.ext that is checked earlier can be sorted out
%         % before an error is thrown. and yes, it throws an error when
%         % missing.
%             if nargin < 2
%                 disp_chk = 0; 
%             end;
%             
%             % check for empty name
%             if isempty(self.name)
%                 error('Name that thang!')
%             end
%             
%                       
%             % check name contents
%             [pth,nm,xt]=fileparts(self.name);        % get name contents
%             
%             % -- path --
%             if ~isempty(pth)                         % check for hidden path
%                 self.path = fullfile(self.path,pth); % concat next pth
%                 self.name = nm;                      % assign new name
%             end
%             
%             % -- ext -- 
%             % check for extension in name
%             if ~isempty(xt)     
%                 self.ext = xt;  % assign next extension
%                 self.name = nm; % assign new name
%             end
%             
%             % check for empty extension
%             if isempty(self.ext)
%                 error('Give an extension, mang!');
%             end
%             
%             % chk file extension for missing dot
%             if ~strcmp(self.ext(1),'.')
%                 % if missing dot, assign to object
%                 self.ext = ['.' self.ext];
%             end
%             
%             % -- disp --
%             
%             % stdout display boolean
%             if disp_chk == 1
%                 fprintf('Current File: %s \n',self.fullname);
%             end
%         end
        
        function fid = open(self,perm)
        %% open() - open file with error screening capability.
        % this function is meant to be a catch-all for catching errors (for
        % lack of a better word) and aid in scalability
        %
        % perm = optional permissions, defaults to read only -> perm = 'r';
        %
            if nargin < 2 % error screen null perm entry
                perm = 'r'; % default to read only
            end
            % open file with permissions
            [fid, errmsg] = fopen(self.fullname,perm);
            if ~isempty(errmsg)
                error(errmsg);
            end
        end  

    %% dependent methods
        function set.name(self,value)
        %%
            if isempty(value)
                error('need a name, dawg');
            end
            
            % look for '.' extension
            ind = regexp(value,'\.');
            if length(ind) > 1 % multiple extensions
                nm = value(1:ind(end)-1); % save name
                xt = value(ind(end):end);   % save last ext 
            end
            
            self.name = nm;
            self.ext = xt;
            
            
            
            
        end
        
        function fullname = get.fullname(self)
        %% fullname
        % get full file name based on path, name, and ext.
        % error screen '.txt' 'txt' possibility
            self.chk_name() % chk file name
            
            % create full path/file name
            fullname = fullfile(self.path,[self.name self.ext]);
        end
    end

%% static methods
	methods (Static)

    end

%% protected methods
	methods (Access = protected)
	end

end
