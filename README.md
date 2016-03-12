#Object Tracking

I used to study the basic approaches of object trackers.
The language used is *MATLAB*.

In this repo you can see two different methods :
- using the Kalman filter
- using the particle filter

If you want more informations especially on the theory, I've done two reports on my work, so don't hesitate to contact me in the case you want to read these. My e-mail adress : `antoine.falck@gmail.com`

## Kalman filter

The goal of this approach is for example to track a plane. And it is exactly what I was interested in as you can see the matrix F. The folder `data` contains the datas I use to plot the results of my algorithms.

In the two other directories I implemented the Kalman filter respectively in the catesian coordinate system and in the polar coordinate system.

## Particle filter

In order to understand how this algorithm works I first implemented it on the Kitagawa model. Then I did my face tracker, which basically uses the comparision on colors distribution to decide were is the face at the current time.
