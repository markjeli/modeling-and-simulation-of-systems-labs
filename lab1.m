g = 10;
a1 = 1;
a2 = 89;
v1 = 1;
v2 = 30;
alphas = [];
vs = [];
accepted_count = 0;
number_of_throws = 100000;

for i = 1:number_of_throws
    a = (a2-a1)*rand() + a1;
    v = (v2-v1)*rand() + v1;
    accept = throw(a, v);
    if accept
        alphas = [alphas a];
        vs = [vs v];
        accepted_count = accepted_count + 1;
    end
end
figure()
plot(alphas, vs, '.');
xlabel('a');
ylabel('v');

figure()
len = length(alphas);
for i = 1:5
    x = 0:.01:15;
    y1= x*tand(alphas(i)) - ((g*x.^2)/(2*vs(i)^2*cosd(alphas(i))^2));
    plot(x,y1); hold on
end

R1x = [3 6];
R1y = [5 5];
pl = line(R1x, R1y);
pl.Color = 'red';
R2x = [3 6];
R2y = [8 8];
pl = line(R2x, R2y);
pl.Color = 'red';
R3x = [2 2];
R3y = [2 11];
pl = line(R3x, R3y);
pl.Color = 'green';
R4x = [7 7];
R4y = [2 11];
pl = line(R4x, R4y);
pl.Color = 'green';
xlabel('x');
ylabel('y');
xlim([0 15]);
ylim([0 15]);

probability = accepted_count / number_of_throws;
fprintf('Probability: %f\n', probability);

function accept = throw(a, v) 
    g = 10;
    accept = true;

    R1x = [3, 6];
    R1y = 5;
    aa = -(g/(2*v.^2*cosd(a).^2));
    b = tand(a);
    c = -R1y;
    discriminant1 = b^2-(4*aa*c);
    if discriminant1 >= 0
        x1 = (-b + sqrt(discriminant1))/(2*aa);
        x2 = (-b - sqrt(discriminant1))/(2*aa);
        if (R1x(1) <= x1 && x1 <= R1x(2)) || (R1x(1) <= x2 && x2 <= R1x(2))
            accept = false;
            return;
        end
    end   

    R2x = [3, 6];
    R2y = 8;
    aa = -g/(2*v^2*cosd(a)^2);
    b = tand(a);
    c = -R2y;
    discriminant2 = b^2-(4*aa*c);
    if discriminant2 >= 0
        x1 = (-b + sqrt(discriminant2))/(2*aa);
        x2 = (-b - sqrt(discriminant2))/(2*aa);
        if (R2x(1) <= x1 && x1 <= R2x(2)) || (R2x(1) <= x2 && x2 <= R2x(2))
            accept = false;
            return;
        end
    end    
    
    R3x = 2;
    R3y = [2, 11];
    y1 = R3x * tand(a) - (g/(2*v.^2 * cosd(a).^2))*R3x.^2;    
    if y1 < 0 || (R3y(1) > y1 || y1 > R3y(2))
        accept = false;
        return;
    end
    R4x = 7;
    R4y = [2, 11];
    y1 = R4x * tand(a) - (g/(2*v.^2 * cosd(a).^2))*R4x.^2;    
    if y1 < 0 || (R4y(1) > y1 || y1 > R4y(2))
        accept = false;
        return;
    end       
end


