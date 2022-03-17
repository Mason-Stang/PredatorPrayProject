%correct pray


else   %prey starts here
    % Code to compute the force to be applied to the prey
        if (((1*Ey) < 0.4*Max_fuel_y) && (10 < norm(py-pr))) %Need to refuel. Adjust constant
        %could have 1*Er - 1*pry
        
        h = 2*abs(((prey_crash_limit - 6)^2 - vyy^2/(2*((Fymax/my)-9.81))));
        
        % (predator_crash_limit-5) < norm(vry^2 + -2*((Frmax-9.8)/mr)*pry))
        if ((vyy <= 0) && (pyy <= h))   %needs max upward force to not reach crash limit
            F = [0;1];
            F = Fymax*F/norm(F);
        else
            F = [0.1 * cos(t); -0.5];
            F= Fymax*F/norm(F);
        end
    else
        if (t<5)
            F = Fymax*[0;1]; %For start of flight
        else

            %old
            %F=[5*sin(t) + cos(t); 10 + cos(t)]; 
            %Pretty good: F=[sin(t); 1.1 + cos(t)];
            %F= Fymax*F/norm(F);



    
             dist = norm(py-pr);
%             switch dist
%                 case dist > 400
%                     dt = 10;
%                 case dist > 300
%                     dt = 8;
%                 case dist > 200
%                     dt = 5;
%                 case dist > 100
%                     dt = 3;
%                 case dist > 50
%                     dt = 2;
%                 otherwise
%                     dt = 1;
%             end
%             vecAway = (py+dt*vy - (pr+dt*vr)); 

            vecAway = py-pr; 
            vecAway = vecAway/norm(vecAway);
    
            vecNormal1 = [1/vecAway(1);-1/vecAway(2)];
            vecNormal2 = [-1/vecAway(1);1/vecAway(2)];
            vecNormal1 = vecNormal1/norm(vecNormal1);
            vecNormal2 = vecNormal2/norm(vecNormal2);
    
            vecReal = vecNormal1;
            pyy = py(2);
            if (pyy < 100) 
                if (vecNormal1(2) >= 0)
                    vecReal = vecNormal1;
                else
                    vecReal = vecNormal2;
                end
            end
    
            weight = dist;
            vecFinal = 100*vecReal + weight*vecAway; %+ [0;1000];
            vecFinal = vecFinal/norm(vecFinal);
            vecFinal = vecFinal*(1-(my*g)/Fymax) + [0;(my*g)/Fymax];
            vecFinal = vecFinal/norm(vecFinal);
            F = Fymax*(vecFinal/norm(vecFinal));
        end
        end
    end