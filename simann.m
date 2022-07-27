function [cozum obj iterasyon] = simann(as,us, d, delta, T, Tend, sk)

% y=f(x)
% min sum(xi^2), [-as,us], i=1,....d, d: problemin boyutu
cozum = unifrnd(as, us, [1,d]); %satır verktörü
obj = sum(cozum.^2);
iterasyon=1;

while T>Tend
    %Komşuya git
    %Komşuluk aralığı +- %5liktir. (üs- as) ın yüzde 5 i
    %Komşuluk büyüklüğü yüzde delta olsun - parametre
    degisim_miktari = unifrnd(-(us-as)*delta/2, (us-as)-delta/2, [1,d]);
    komsu= cozum+degisim_miktari;
    
    obj_komsu = sum(komsu.^2);
    % Geldiğin yer iyiyse orayı çözüm olarak kabul et
    % Geldiğin yer kötüyse kabul olasılığı hesapla
    if obj_komsu <= obj
        cozum = komsu;
        obj= obj_komsu ; 
    else %probability of acceptance : amaç fonksiyonunun ne kadar kötüleştiğini ölçer pa: p(deltaE,T)= e üssü (-deltaE/T)
        de=obj_komsu-obj;
        pa = exp(-de/T);
        rs=unifrnd(0,1);
        if rs<pa
            cozum = komsu;
            obj= obj_komsu ;
        end
        
    end
    %% 
    T = T*sk;
    iterasyon=iterasyon+1;
  
end

end

%sk sistemin sıcaklığının ne kadrının korunacağı anlamına gelir
