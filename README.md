# Machine Learning - Lyd

Vi har lavet et lille projekt, hvor vi skal bruge machine learning med Processing og Wekinator, for at lave fem forskellige toner. </br>
Jeg har i projektet gjort, så mit input til modellen er mit kamera, som sender 400 pixels i gråtoner. Derefter træner jeg modellen, så når jeg står ét sted, så giver den outputtet 'klasse 2', et andet sted 'klasse 3', osv. Jeg har beholdt 'klasse 1' til at give standard-outputtet, som i Processing sætter frekvensen på tonen til 0, som er for dybt til hverken højtaleren kan spille det, eller vi kan høre det. </br>
Så denne måde ligger mine output med toner fra klasse 2-6. </br>
Frekvenserne ligger på følgende toner og frekvenser: </br>
C (523.25 hz) </br>
g (783.99 hz) </br>
c (1046.50 hz) </br>
d (1174.66 hz) </br>
e (1318.51 hz) </br>
Modellen kører på 3-Nearest Neighbor, hvilket er en måde at lave classification. Jeg valgte denne måde, da den fungerede bedst-i-test.
