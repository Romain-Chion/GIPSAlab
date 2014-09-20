function [L,E1,E2]=lap_spect(A,bool)
% LAP_SPECT   Get all graph data contained in a csv file
%
%   data_csv: fileID of the csv file
%   measures: cell array of text names of measures used
%   labels  : cell array of text labels of generative methodes used
%   data    : matrix of all measure values
%
%   See also TXT2GRAPH,CSV2GRAPH

    L=-A+diag(sum(A));
    E1=eig(L);
    E2=sort(E1);
    if bool
    scrsz=get(0,'ScreenSize');
    figure('Name',['Graph Spectrum Analysis'],'NumberTitle','off',...
               'Position',[(scrsz(3)-1000)/2 (scrsz(4)-450)/2 1000 450]);
    subplot(1,2,1);
    plot(E1);
    title('Before sorting');
    subplot(1,2,2);
    plot(E2);
    title('After sorting');
    end
end