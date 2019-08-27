function [] = save_heatmap(tbl,path, Xvar,Yvar,Cvar,title,xlabel,ylabel)
h = heatmap(tbl, Xvar,Yvar,'ColorVariable', Cvar);
h.Title = title;
h.XLabel = xlabel;
h.YLabel = ylabel;
saveas(h, path, "png");


end