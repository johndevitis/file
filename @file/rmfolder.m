function rmfolder(self)
%% rmfolder
% 
% removes the trailing folder in self.path
%  effectivly `cd ..` to the object path
% 
% author: john devitis
% create date: 20-Oct-2016 20:12:52
	self.path = fileparts(self.path);	
end
