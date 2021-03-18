% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;                          % Lower cladding
n2 = linspace(3.305,3.44,10);       % Core
n3 = 1.00;                          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125*8;        % grid size (horizontal)
dy = 0.0125*8;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

Neff_vector = zeros(1, 10);

for j = 1: 10
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2(j),n3],[h1,h2,h3], ...
                                                rh,rw,side,dx,dy); 

    % First consider the fundamental TE mode:

    [Hx,Hy,neff] = wgmodes(lambda,n2(j),nmodes,dx,dy,eps,'000A');
    
    fprintf(1,'neff = %.6f\n',neff);
    Neff_vector(1, j) = neff;
    
    for i = 1: nmodes
        figure();
        subplot(121);
        contourmode(x,y,Hx(:,:,i));
        title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 

        subplot(122);
        contourmode(x,y,Hy(:,:,i));
        title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    end
end

figure()
plot(n2,Neff_vector(1,:))
title('Effect of Ridge Index on Neff')
xlabel('Ridge Index')
ylabel('Neff')