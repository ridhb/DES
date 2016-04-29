clc, clear all
plain(1,:)=randint(1,64)
key=randint(1,64);
cipher=enkripsi_des(plain(1,:), key);
plain(2,:)=dekripsi_des(cipher, key)
