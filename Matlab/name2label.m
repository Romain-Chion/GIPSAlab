% Get the label of a generative methode from a string name of a file
function label=name2label(name)
if strfind(name,'Small-World')
    label='Small-World';
elseif strfind(name,'Random_Power_Law')
    label='Random Power Law';
elseif strfind(name,'Random_k-regular')
    label='Random k-regular';
elseif strfind(name,'Preferential_Attachment')
    label='Preferential Attachment';
elseif strfind(name,'Kronecker_Graph')
    label='Kronecker Graph';
elseif strfind(name,'Forest_Fire')
    label='Forest Fire';
elseif strfind(name,'Erdos-Renyi')
    label='Erdos-Renyi';
elseif strfind(name,'Copyin_Model')
    label='Copying Model';
elseif strfind(name,'Community_Affiliation')
    label='Community Affiliation';
elseif strfind(name,'Control')
    label='Control';
elseif strfind(name,'Patient')
    label='Patient';
else
    label='no known methode';
end
end