# A Simulation based Study on the Effects of SNR in Wireless Communication using BPSK and QPSK modulation

## INTRODUCTION
#### SNR
Signal-to-noise ratio (SNR or S/N) is a measure that compares the level of a desired signal to the level of background noise. SNR is defined as the ratio of signal power to the noise power, often expressed in decibels(dB). A ratio higher than 1:1 (greater than 0 dB) indicates more signal than noise.

![image](https://user-images.githubusercontent.com/86975877/148813866-2bed45ba-803d-4a0c-a6ad-ef4ba0a44f92.png)

#### BPSK 
A two-phase modulation scheme, where the 0’s and 1’s in a binary message are represented by two different phase states in the carrier signal: 0(degree) for binary 1 and 180(degree) for binary 0.
    
![image](https://user-images.githubusercontent.com/86975877/148814950-522dde3d-3899-459f-82ae-6908c65b6403.png)
    
#### QPSK
Quadrature Phase Shift Keying (QPSK) is a form of Phase Shift Keying in which two bits are modulated at once, selecting one of four possible carrier phase shifts (45, 135, 225, or 315 degrees). QPSK allows the signal to carry twice as much information as ordinary PSK using the same bandwidth. QPSK is used for satellite transmission of MPEG2 video, cable modems, videoconferencing, cellular phone systems, and other forms of digital communication over an RF carrier.

![image](https://user-images.githubusercontent.com/86975877/148815092-7431edd8-4c11-4874-9a1d-a9cb8c9c9650.png)

## PROBLEM STATEMENT

### 1. TASK 1
1. Pick an image of your choice
2. Convert the image to bits
3. Convert the bits into a sequence of frames
4. Apply CRC on each frame to get CRC-encoded frame. CRC-encoded frame is the frame along with the tag
5. Modulate the CRC-encoded frame using BPSK and QPSK
6. Send the modulated symbols on AWGN channel of a certain SNR
7. Demodulate the symbols
8. Apply CRC and check for errors
9. Ask for retransmissions if the frame is in error

### 2. TASK 2
1. With SNR = [0dB 5 dB 10 dB 15 dB] and BPSK modulation, find out how many retransmissions are required to reconstruct the image at the receiver
2. With SNR = [0dB 5 dB 10 dB 15 dB] and QPSK modulation, find out how many retransmissions are required to reconstruct the image at the receiver
3. Increase the length of tag and repeat the above two tasks. Comment on the observations.

## IMPLEMENTATION
### 1. TASK 1

1. User was asked to choose between the 4 standard CRC polynomials 4-bit CRC 8-bit CRC 16- bit CRC 32-bit CRC
2. User was asked to input the SNR
3. Following modulations has been done
    - BPSK without CRC
    - BPSK with CRC and error correction
    - QPSK without CRC
    - QPSK with CRC and error correction
4. All these received bits have been reconstructed and the received images are displayed below
5. Number of retransmissions required were also calculated

TEST WAS DONE WITH FOLLOWING DATA
- Original Image size = 200 x 200 x 3 pixels
- Number of frames = 12000
- Frame size = 80 bits
- CRC polynomial used : 'z^8 + z^7 + z^6 + z^4 + z^2 + 1'
- SNR = 5dB

RETRANSMISSIONS:
- No of retransmissions done for BPSK = 334618
- No of retransmissions doe for QPSK= 20152

OUTPUT IMAGES :

![image](https://user-images.githubusercontent.com/86975877/148815730-42646e98-c5e7-4549-b804-71a6b81dd3da.png)

### 2. TASK 2

1. User was asked to choose between the 4 standard CRC polynomials 4-bit CRC 8-bit CRC 16- bit CRC 32-bit CRC
2. Both BPSK and QPSK modulations were done with CRC with all the following SNR values
    1. 0 dB
    2. 5 dB
    3. 10 dB
    4. 15 dB
3. All these received bits have been reconstructed and the received images are displayed below
4. Number of retransmissions required were also calculated

TEST WAS DONE WITH FOLLOWING DATA

- Original Image size = 200 x 200 x 3 pixels
- Number of frames = 12000
- Frame size = 80 bits
- CRC polynomial used: 'z^8 + z^7 + z^6 + z^4 + z^2 + 1'
- SNR = [ 0dB 5dB 10dB 15dB]

RETRANSMISSIONS

![image](https://user-images.githubusercontent.com/86975877/148816593-9e80153d-ea55-48a5-a128-9dc7d679c7e4.png)

OUTPUT IMAGES:

![image](https://user-images.githubusercontent.com/86975877/148816667-77eae1af-a5ee-4736-9139-971a5eb60b0b.png)

### GRAPH

1. BPSK: No of retransmissions (in log scale) vs SNR

![image](https://user-images.githubusercontent.com/86975877/148816781-b26b6468-9144-4c14-90cc-61072089b5a5.png)

2. QPSK: No of retransmissions (in log scale) vs SNR

![image](https://user-images.githubusercontent.com/86975877/148816836-0dc04ab2-3a66-4d06-87cc-0a535b915f38.png)

## CONCLUSION

Following conclusions have been inferred form the simulations performed in MATLAB
- As CRC polynomial degree was increased
    - No of retransmissions increased
    - Slower transmission and reception (need to append more CRC bits)
    - But error in the image bits got reduced
• In both BPSK and QPSK as SNR is increased, the number of retransmissions reduced and the noise in the image also got lower.
• Performance in QPSK was better because by the modulation scheme we chose, QPSK was given more energy per symbol which resulted in better image outputs using QPSK. (It is evident form the image outputs)








