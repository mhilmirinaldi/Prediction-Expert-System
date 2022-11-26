(defrule have-hbsag
=>
(printout t "HBsAg? ")
(assert (hbsag(read)))
)

(defrule have-anti-hdv
(hbsag positive)
=>
(printout t "anti-HDV? ")
(assert (anti-hdv(read)))
)

(defrule have-hepatitis-b+d
(anti-hdv positive)
=>
(printout t crlf"Hasil Prediksi = Hepatitis B + D" crlf)
)

(defrule have-anti-hbc
(and (hbsag positive) (anti-hdv negative))
=>
(printout t "anti-HBC? ")
(assert (anti-hbc(read)))
)

(defrule uncertain-configuration-1
(and (hbsag positive) (anti-hdv negative) (anti-hbc negative))
=>
(printout t crlf"Hasil Prediksi = Uncertain configuration" crlf)
)

(defrule have-anti-hbs
(and (hbsag positive) (anti-hdv negative) (anti-hbc positive))
=>
(printout t "anti-HBs? ")
(assert (anti-hbs(read)))
)

(defrule uncertain-configuration-2
(and (hbsag positive) (anti-hdv negative) (anti-hbc positive) (anti-hbs positive))
=>
(printout t crlf"Hasil Prediksi = Uncertain configuration" crlf)
)

(defrule have-igm-anti-hbc
(and (hbsag positive) (anti-hdv negative) (anti-hbc positive) (anti-hbs negative))
=>
(printout t "IgM anti-HBC? ")
(assert (igm-anti-hbc(read)))
)

(defrule have-acute-infection
(and (hbsag positive) (anti-hdv negative) (anti-hbc positive) (anti-hbs negative) (igm-anti-hbc positive))
=>
(printout t crlf"Hasil Prediksi = Acute infection" crlf)
)

(defrule have-chronic-infection
(and (hbsag positive) (anti-hdv negative) (anti-hbc positive) (anti-hbs negative) (igm-anti-hbc negative))
=>
(printout t crlf"Hasil Prediksi = Chronic infection" crlf)
)

