function [dist] = sqrdist(a,b)

dist1 = a(1)-b(1);
dist2 = a(2)-b(2);
dist = sqrt((dist1^2)+(dist2^2));

