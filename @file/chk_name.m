function chk_name(self,disp_chk)
%% DEPRECATED - will be removed in next release
fprintf('fcn: chk_name is deprecated and will be removed soon. carry on. \n');
%% chk_name(0)
% * checks for an empty object name, throws an error if found. 
% * also checks for hidden path or extension info in name
% * use disp_chk = 1 to display current file path to user, else
% function only error screens null name
% * at end of fcn chk_name checks for missing ext field. this is so
% the nested filename.ext that is checked earlier can be sorted out
% before an error is thrown. and yes, it throws an error when
% % missing.
%     if nargin < 2
%         disp_chk = 0; 
%     end
% 
%     % check for empty name
%     if isempty(self.name)
%         error('Name that thang!')
%     end
% 
%     
%     % extract name contents
%     [pth,nm,xt]=fileparts(self.name);        % get name contents
% 
%     % -- path --
%     if ~isempty(pth)                         % check for hidden path
%         self.path = fullfile(self.path,pth); % concat next pth
%         self.name = nm;                      % assign new name
%     end
% 
%     % -- ext -- 
% %     % check for extension in name
% %     if ~isempty(xt)     
% %         self.ext = xt;  % assign next extension
% %         self.name = nm; % assign new name
% %     end
% 
% %     % check for empty extension
% %     if isempty(self.ext)
% %         error('Give an extension, mang!');
% %     end
% 
% %     % chk file extension for missing dot
% %     if ~strcmp(self.ext(1),'.')
% %         % if missing dot, assign to object
% %         self.ext = ['.' self.ext];
% %     end
% 
%     % -- disp --
% 
% %     % stdout display boolean
% %     if disp_chk == 1
% %         fprintf('Current File: %s \n',self.fullname);
% %     end
% end