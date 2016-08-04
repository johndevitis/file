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
        
    %% ordinary        
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
        % note 
        % * path inside of name will rewrite path
        % 
            if isempty(value)
                error('need a name, dawg');
            end
            
            % look for embedded path
            pth = fileparts(value);
            if ~isempty(pth)        % check for included path
                self.path = pth;    % over write current path
            end
            
            % look for '.' extension
            ind = regexp(value,'\.');
            if ~isempty(ind)     % multiple extensions
                self.name = value(1:ind(end)-1); % save name
                self.ext  = value(ind(end):end);   % save last ext 
            end
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
        out = insidequotes(in);
    end

%% protected methods
	methods (Access = protected)
	end

end
