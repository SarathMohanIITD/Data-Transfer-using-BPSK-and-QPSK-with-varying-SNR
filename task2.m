bpsk_img0=[];bpsk_img5=[];bpsk_img10=[];bpsk_img15=[];
qpsk_img0=[];qpsk_img5=[];qpsk_img10=[];qpsk_img15=[];
k=0;
re=zeros(1,8); %Retransmission count vector
frame_size=80;
%open the image
imag= imread('frog1.jpg'); %(200 X 200 X 3 )
bin_img=de2bi(imag,8);  %convert to 8 bit binary
bin_img= double(bin_img);
%setting a data frame to 100 X 8 = 800 bits per frame
bin_img = reshape( bin_img,[],frame_size);
no_of_frames = size(bin_img,1);
%type conversion for comm.CRCGenerator 
option = input('Choose the corresponding option for the required degree of CRC polynomial required \n 4  >>> CRC 4 \n 8  >>> CRC 8\n 16 >>> CRC 16\n 32 >>> CRC 32\n ------ ');
if option == 4
       poly = 'z^4 + z^3 + z^2 + z + 1';
elseif option ==8
   poly = 'z^8 + z^7 + z^6 + z^4 + z^2 + 1';
elseif option == 16
   poly = 'z^16 + z^15 + z^2 + 1';
elseif option == 32
   poly = 'z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1';
else
   tx_bits=-1;
   return
end
% crc generator object-----------------------------------------------------
crcgenerator = comm.CRCGenerator('Polynomial',poly);
crcdetector = comm.CRCDetector('Polynomial',poly);

%%
%For loop for each frame --------------------------------------------------
for i = 1:size(bin_img,1)
    tx_bits = crcgenerator(bin_img(i,:).'); 
    tx_bits = tx_bits.';
%BPSK---------------------------------------------------------------------- 
    
    tx_bpsk = bpsk_mod(tx_bits); %func for bpsk modulation
     
    %BPSK with 0dB
    err=ones(option); %initializing error vector
    while(~(all(err(:) == 0)))                     % Error check
        rx_bpsk = awgn(tx_bpsk,0);             % channel with snr =0 dB 
        rx_bpsk = bpsk_demod(rx_bpsk);         %demodulation func
        [a1,err] = crcdetector(rx_bpsk.');       %crc detection
        if (all(err(:) == 0))
            bpsk_img0= [bpsk_img0 a1]; 
        end
        re(1) = re(1)+1;
    end
    
    %BPSK with snr =5dB
    err=ones(option);
    while(~(all(err(:) == 0)))                 % Error check
        rx_bpsk = awgn(tx_bpsk,5);             % channel with snr =5 dB 
        rx_bpsk = bpsk_demod(rx_bpsk);         %demodulation func
        [a1,err] = crcdetector(rx_bpsk.');       %crc detection
        if (all(err(:) == 0))
            bpsk_img5= [bpsk_img5 a1]; 
        end
        re(2) = re(2)+1;
    end
    
    %BPSK with snr =10dB
    err=ones(option);
    while(~(all(err(:) == 0)))                 % Error check
        rx_bpsk = awgn(tx_bpsk,10);             % channel with snr =10 dB 
        rx_bpsk = bpsk_demod(rx_bpsk);         %demodulation func
        [a1,err] = crcdetector(rx_bpsk.');       %crc detection
        if (all(err(:) == 0))
            bpsk_img10= [bpsk_img10 a1]; 
        end
        re(3) = re(3)+1;
    end
    
    %BPSK with snr =15dB
    err=ones(option);
    while(~(all(err(:) == 0)))                 % Error check
        rx_bpsk = awgn(tx_bpsk,15);             % channel with snr =15 dB 
        rx_bpsk = bpsk_demod(rx_bpsk);         %demodulation func
        [a1,err] = crcdetector(rx_bpsk.');       %crc detection
        if (all(err(:) == 0))
            bpsk_img15= [bpsk_img15 a1]; 
        end
        re(4) = re(4)+1;
    end
    
%%    
% QPSK---------------------------------------------------------------------  
    tx_qpsk = qpsk_mod(tx_bits); %func for bpsk modulation  
    
    %QPSK with 0dB
    err=ones(option); %initializing error vector
    while(~(all(err(:) == 0)))                    % Error check
        rx_qpsk = awgn(tx_qpsk,0);              % dB channel  
        rx_qpsk = qpsk_demod(rx_qpsk);        %demodulation func
        [b1,err] = crcdetector(rx_qpsk.');      %crc detection
        if (all(err(:) == 0)) 
            qpsk_img0= [qpsk_img0 b1]; 
        end
        re(5) = re(5)+1;
    end
    
    %QPSK with 5dB
    err=ones(option); %initializing error vector
    while(~(all(err(:) == 0)))                    % Error check
        rx_qpsk = awgn(tx_qpsk,5);              % dB channel  
        rx_qpsk = qpsk_demod(rx_qpsk);        %demodulation func
        [b1,err] = crcdetector(rx_qpsk.');      %crc detection
        if (all(err(:) == 0)) 
            qpsk_img5= [qpsk_img5 b1]; 
        end
        re(6) = re(6)+1;
    end
     
    %QPSK with 10dB
    err=ones(option); %initializing error vector
    while(~(all(err(:) == 0)))                    % Error check
        rx_qpsk = awgn(tx_qpsk,10);              % dB channel  
        rx_qpsk = qpsk_demod(rx_qpsk);        %demodulation func
        [b1,err] = crcdetector(rx_qpsk.');      %crc detection
        if (all(err(:) == 0)) 
            qpsk_img10= [qpsk_img10 b1]; 
        end
        re(7) = re(7)+1;
    end
     
    %QPSK with 15dB
    err=ones(option); %initializing error vector
    while(~(all(err(:) == 0)))                    % Error check
        rx_qpsk = awgn(tx_qpsk,15);              % dB channel  
        rx_qpsk = qpsk_demod(rx_qpsk);        %demodulation func
        [b1,err] = crcdetector(rx_qpsk.');      %crc detection
        if (all(err(:) == 0)) 
            qpsk_img15= [qpsk_img15 b1]; 
        end
        re(8) = re(8)+1;
    end
end

%CONVERSION OF BITS TO IMAGES----------------------------------------------

img1=convert(bpsk_img0);
img2=convert(bpsk_img5);
img3=convert(bpsk_img10);
img4=convert(bpsk_img15);
img5=convert(qpsk_img0);
img6=convert(qpsk_img5);
img7=convert(qpsk_img10);
img8=convert(qpsk_img15);

h1 = subplot(4,4,1); imshow(img1, 'Parent', h1); title(h1, 'BPSK 0 dB'); 
h2 = subplot(4,4,2); imshow(img2, 'Parent', h2); title(h2, 'BPSK 5dB');
h3 = subplot(4,4,3); imshow(img3, 'Parent', h3); title(h3, 'BPSK 10 dB'); 
h4 = subplot(4,4,4); imshow(img4, 'Parent', h4); title(h4, 'BPSK 15dB');
h5 = subplot(4,4,5); imshow(img5, 'Parent', h5); title(h5, 'QPSK 0 dB'); 
h6 = subplot(4,4,6); imshow(img6, 'Parent', h6); title(h6, 'QPSK 5dB');
h7 = subplot(4,4,7); imshow(img7, 'Parent', h7); title(h7, 'QPSK 10 dB'); 
h8 = subplot(4,4,8); imshow(img8, 'Parent', h8); title(h8, 'QPSK 15dB'); 
sgtitle('BPSK vs QPSK ');

re= re-120
%% 


%FUNCTIONS-----------------------------------------------------------------

%BPSK MODULATION-----------------------------------------------------------
function bpsk_tx_code =bpsk_mod(tx_bits)
    bpsk_tx_code= 2*tx_bits - 1;
end
%BPSK DEMODULATION
function rx_bits = bpsk_demod(rx_code)
    rx_bits=[];
    for i = 1:size(rx_code,2)
       if rx_code(i)<0
           rx_bits=[rx_bits 0];
       else
           rx_bits=[rx_bits 1];
       end
    end
end

%QPSK MODULATION-----------------------------------------------------------
function tx_code = qpsk_mod(tx_bits)
    tx_code = [];
    levels =[1+i -1+i -1-i 1-i]; 
    for j = 1:2:length(tx_bits)
        if [tx_bits(j) tx_bits(j+1)] == [0 0]
            tx_code = [tx_code levels(1)];
        elseif [tx_bits(j) tx_bits(j+1)] == [0 1]
            tx_code = [tx_code levels(2)];
        elseif [tx_bits(j) tx_bits(j+1)] == [1 0]
            tx_code = [tx_code levels(3)];
        else
            tx_code = [tx_code levels(4)];
        end        
    end
end

%QPSK DEMODULATION
function rx_bits = qpsk_demod(rx_code)
    rx_bits = [];
    levels =[1+i -1+i -1-i 1-i];
    for j= 1:length(rx_code)
        mse1 = (rx_code(j) - levels(1)).^2;
        mse2 = (rx_code(j) - levels(2)).^2; 
        mse3 = (rx_code(j) - levels(3)).^2;
        mse4 = (rx_code(j) - levels(4)).^2;      
        [min_value,min_pos] = min([mse1,mse2,mse3,mse4]);
        if min_pos ==1
            rx_bits= [rx_bits 0  0];
        elseif min_pos ==2
            rx_bits= [rx_bits 0 1];
        elseif min_pos ==3
            rx_bits= [rx_bits 1 0];
        else
            rx_bits= [rx_bits 1 1];
        end
    end
end
    
% CONVERT FUNCTION
function img1 = convert(img)
    img = reshape(img.',[],8);
    img=bi2de(img);   %convert to decimal
    img=reshape(img,200,200,3); %reshape to input image dimensions
    img1=uint8(img);
end   
