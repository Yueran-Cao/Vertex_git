
function [ sigma ] = activationfunction( point1,point2, stimfieldtri,t )

    delta = 0.00001;
    grad = point1 - point2;
    point1d = point1 + delta*grad;
    point2d = point2 - delta*grad;
    
    if isa(stimfieldtri,'pde.StationaryResults')
        EPpoint1 = interpolateSolution(stimfieldtri, point1);
        EPpoint2 = interpolateSolution(stimfieldtri, point2);
        EPpoint1d = interpolateSolution(stimfieldtri, point1d);
        EPpoint2d = interpolateSolution(stimfieldtri, point2d);
    elseif isa(stimfieldtri,'pde.StationaryResults')
          EPpoint1 = interpolateSolution(stimfieldtri, point1,t);
        EPpoint2 = interpolateSolution(stimfieldtri, point2,t);
        EPpoint1d = interpolateSolution(stimfieldtri, point1d,t);
        EPpoint2d = interpolateSolution(stimfieldtri, point2d,t);
    else
        EPpoint1 = evaluate(stimfieldtri,point1);
        EPpoint2 = evaluate(stimfieldtri,point2);
        EPpoint1d = evaluate(stimfieldtri,point1d);
        EPpoint2d = evaluate(stimfieldtri,point2d);
    end

    delta_u_point1 = (EPpoint1 - EPpoint1d)./delta;

    delta_u_point2 = (EPpoint2 - EPpoint2d)./delta;

    sigma = (delta_u_point1 - delta_u_point2);

    sigma(isnan(sigma)) = 0; 
    
end

