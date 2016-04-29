function  [outputplain_des] = dekripsi_des(inputciph_des, kunci_des)
load data;
y=inputciph_des;
x=kunci_des;
%----------------------------------------------------
% pembuatan PC-1 ------------------------------------
pc1=reshape(pc1',1,8*7);
for i=1:8*7
    xa(i)=x(pc1(i));
end
c(1,:)=xa(1:4*7);
d(1,:)=xa(4*7+1:8*7);

% pembuatan key PC-2
for j=1:16
    c(j+1,:)=[c(j,it(j)+1:4*7) c(j,1:it(j))];
    d(j+1,:)=[d(j,it(j)+1:4*7) d(j,1:it(j))];
    xb=[c(j+1,:) d(j+1,:)];
    pc2=reshape(pc2',1,8*6);
    for i=1:8*6
        xc(i)=xb(pc2(i));
    end
    k(j,:)=xc;
end
%-------------------------------------------------------
% proses plaintext -------------------------------------
pa=reshape(pa',1,8*8);
for i=1:8*8
    ya(i)=y(pa(i));
end

R(1,:)=ya(1:4*8);
L(1,:)=ya(4*8+1:8*8);

%----------------------------------------------------
for j=2:17
    
    %----------------------------------------------------
    % pembuatan Tabel-E
    te=reshape(te',1,8*6);
    for i=1:8*6
        Ra(i)=R(j-1,te(i));
    end
    
    A=xor(Ra,k(18-j,:));
    % pembuatan subtitusi
    for i=1:8
        baris=num2str([A(6*i-5) A(6*i)]);
        kolom=num2str([A(6*i-4:6*i-1)]);
        barisx=bin2dec([baris(1) baris(4)]);
        kolomx=bin2dec([kolom(1) kolom(4) kolom(7) kolom(10)]);
        if i==1
            sa=s1(barisx+1,kolomx+1);
        elseif i==2
            sa=s2(barisx+1,kolomx+1);
        elseif i==3
            sa=s3(barisx+1,kolomx+1);
        elseif i==4
            sa=s4(barisx+1,kolomx+1);
        elseif i==5
            sa=s5(barisx+1,kolomx+1);
        elseif i==6
            sa=s6(barisx+1,kolomx+1);
        elseif i==7
            sa=s7(barisx+1,kolomx+1);
        elseif i==8
            sa=s8(barisx+1,kolomx+1);
        end
        B(1,4*i-3:4*i)=dec2bin(sa,4);
    end
    % pembuatan P(B)
    pb=reshape(pb',1,8*4);
    for i=1:8*4
        Ba(i)=str2num(B(pb(i)));
    end
    
    
    
    
    % nilai L & R
    L(j,:)=R(j-1,:);
    R(j,:)=xor(Ba,L(j-1,:));
    
    %----------------------------------------------------
end
%---------------------------------------------------
%yb=[L(2,:) R(2,:)];
yb=[R(17,:) L(17,:)];
px=reshape(px',1,8*8);
for i=1:8*8
    Out(i)=yb(px(i));
end
outputplain_des=Out;