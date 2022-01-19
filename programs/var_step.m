clear all;

A = [0 0 1;0 -10 -100;-10000 10000 0];
B = [0 100 0]';

h1 = 1e-6;
h2 = 1e-2;

eig(A)
time=[(0:h1:1) (1+h2:h2:20)]';
%time=[(0:h1:1)]';
x = zeros(3,size(time,1));
error = zeros(1,size(time,1));

for k = 2:size(time,1)
  h = time(k,1)-time(k-1,1);
  x(:,k) = (inv(eye(3)-A*h))*x(:,k-1) + (inv(eye(3)-A*h))*B*h;
  error(:,k) = norm(A*A*x(:,k),2)*h^2/2;
endfor

figure();
subplot(3,1,1);
plot(time,x(1,:),'b-','linewidth',2);
xlabel('Time, s');
ylabel('State variables');
grid on;
title('1 H inductor current');
set(gca,'fontsize',20,'linewidth',2);
grid on;
subplot(3,1,2);
plot(time,x(2,:),'b-','linewidth',2);
grid on;
xlabel('Time, s');
ylabel('State variables');
grid on;
title('10 mH inductor current');
set(gca,'fontsize',20,'linewidth',2);
subplot(3,1,3);
plot(time,x(3,:),'b-','linewidth',2);
grid on;
xlabel('Time, s');
ylabel('State variables');
grid on;
title('100 \mu F capacitor voltage');
set(gca,'fontsize',20,'linewidth',2);

figure();
plot(time,error,'r-');