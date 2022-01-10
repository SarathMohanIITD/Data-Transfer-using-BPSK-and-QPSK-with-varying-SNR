bpsk_img1=[];qpsk_img1=[];
bpsk_img=[];qpsk_img=[];
k=0;
re=zeros(1,2); %Retransmission count vector
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
snr = input('\n Enter SNR in dB ');
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
%CRC GENERATOR OBJECT -----------------------------------------------------
crcgenerator = comm.CRCGenerator('Polynomial',poly);
crcdetector = comm.CRCDetector('Polynomial',poly);

%For loop for each frame --------------------------------------------------
for i = 1:size(bin_img,1)
%%  
    tx_bits =bin_img(i,:);
    % BPSK with out retransmission
    tx_bpsk1 = bpsk_mod(tx_bits);
    rx_bpsk1=  awgn(tx_bpsk1,snr); 
    rx_bpsk1 = bpsk_demod(rx_bpsk1);  %demodulation func   
    bpsk_img1= [bpsk_img1;rx_bpsk1];
%%    
     % qpsk_with out retransmission
    tx_qpsk1 = qpsk_mod(tx_bits);   
    rx_qpsk1 = awgn(tx_qpsk1,snr); % creating awgn channel for qpsk
    rx_qpsk1 = qpsk_demod(rx_qpsk1);
    qpsk_img1= [qpsk_img1;rx_qpsk1];
      
 %%   
    %BPSK with CRC
    err=ones(option); %initializing error vector
    tx_bits = crcgenerator(bin_img(i,:).'); 
    tx_bits = tx_bits.';
    tx_bpsk = bpsk_mod(tx_bits); %func for bpsk modulation
              
    while(~(all(err(:) == 0)))                     % Error check
        rx_bpsk = awgn(tx_bpsk,snr);                   % channel  
        rx_bpsk = bpsk_demod(rx_bpsk);         %demodulation func
        [a1,err] = crcdetector(rx_bpsk.');       %crc detection
        if (all(err(:) == 0))
            bpsk_img= [bpsk_img a1]; 
        end
        re(1) = re(1)+1;
    end
%%    
    % QPSK with CRC   
    err=ones(option); %initializing error vector
    tx_qpsk = qpsk_mod(tx_bits); %func for bpsk modulation            
    while(~(all(err(:) == 0)))                    % Error check
        rx_qpsk = awgn(tx_qpsk,snr);              % dB channel  
        rx_qpsk = qpsk_demod(rx_qpsk);        %demodulation func
        [b1,err] = crcdetector(rx_qpsk.');      %crc detection
        if (all(err(:) == 0)) 
            qpsk_img= [qpsk_img b1]; 
        end
        re(2) = re(2)+1;
    end
   
end
%%
img1 = reshape(bpsk_img1,[],8);  % BPSK without crc
img2 = reshape(bpsk_img.',[],8);    % BPSK with crc
img3 = reshape(qpsk_img1,[],8);  % QPSK without crc
img4 = reshape(qpsk_img.',[],8);    % QPSK with crc
%convert to decimal
img1=bi2de(img1);   
img2=bi2de(img2);
img3=bi2de(img3);
img4=bi2de(img4); 
%reshape to input image dimensions
img1=reshape(img1,200,200,3); 
img2=reshape(img2,200,200,3);
img3=reshape(img3,200,200,3);
img4=reshape(img4,200,200,3);
%convert to uint
img1=uint8(img1);
img2=uint8(img2);
img3=uint8(img3);
img4=uint8(img4);
re = re -120;
re
h1 = subplot(2,2,1); imshow(img1, 'Parent', h1); title(h1, 'BPSK without crc'); 
h2 = subplot(2,2,2); imshow(img2, 'Parent', h2); title(h2, 'BPSK with crc');
h3 = subplot(2,2,3); imshow(img3, 'Parent', h3); title(h3, 'QPSK without crc '); 
h4 = subplot(2,2,4); imshow(img4, 'Parent', h4); title(h4, 'QPSK with crc');



%% 
%FUNCTIONS-----------------------------------------------------------------
%CRC CREATOR---------------------------------------------------------------

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
