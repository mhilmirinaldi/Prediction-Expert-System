(deffunction ask-question (?question $?allowed-values)
	(printout t ?question)
	(bind ?answer (read))
	(if (lexemep ?answer)
		then (bind ?answer (lowcase ?answer)))
	(while (not (member$ ?answer ?allowed-values)) do
		(printout t ?question)
		(bind ?answer (read))
		(if (lexemep ?answer)
			then (bind ?answer (lowcase ?answer))))
	?answer
)

(deffunction true-or-false (?question)
	(bind ?response (ask-question ?question true false t f))
	(if (or (eq ?response true) (eq ?response t))
		then true
		else false)
)

(defrule have-hbsag
    =>
    (assert (hbsag-positive(true-or-false "HBsAg = positive? [true/false]: ")))
)

(defrule have-anti-hdv
    (hbsag-positive true)
    =>
    (assert (anti-hdv-negative(true-or-false "anti-HDV = negative? [true/false]: ")))
)

(defrule have-anti-hbc
    (or 
    (and (hbsag-positive true) (anti-hdv-negative true))
    (and (hbsag-positive false) (anti-hbs-positive ?)))
    =>
    (assert (anti-hbc-positive(true-or-false "anti-HBc = positive? [true/false]: ")))
)

(defrule have-anti-hbs
    (or
    (and (hbsag-positive true) (anti-hdv-negative true) (anti-hbc-positive true))
    (and (hbsag-positive false)))
    =>
    (assert (anti-hbs-positive(true-or-false "anti-HBs = positive? [true/false]: ")))
)

(defrule have-igm-anti-hbc
    (and (hbsag-positive true) (anti-hdv-negative true) (anti-hbc-positive true) (anti-hbs-positive false))
    =>
    (assert (igm-anti-hbc-positive(true-or-false "IgM anti-HBc = positive? [true/false]: ")))
)

(defrule have-hepatitis-b+d
    (and (hbsag-positive true) (anti-hdv-negative false))
    =>
    (printout t crlf"Hasil Prediksi = Hepatitis B + D" crlf)
)

(defrule have-acute-infection
    (and (hbsag-positive true) (anti-hdv-negative true) (anti-hbc-positive true) (anti-hbs-positive false) (igm-anti-hbc-positive true))
    =>
    (printout t crlf"Hasil Prediksi = Acute infection" crlf)
)

(defrule uncertain-configuration
    (or 
    (and (hbsag-positive true) (anti-hdv-negative true) (anti-hbc-positive false))
    (and (hbsag-positive true) (anti-hdv-negative true) (anti-hbc-positive true) (anti-hbs-positive true)))
    =>
    (printout t crlf"Hasil Prediksi = Uncertain configuration" crlf)
)

(defrule have-chronic-infection
    (and (hbsag-positive true) (anti-hdv-negative true) (anti-hbc-positive true) (anti-hbs-positive false) (igm-anti-hbc-positive false))
    =>
    (printout t crlf"Hasil Prediksi = Chronic infection" crlf)
)

(defrule have-cured
    (and (hbsag-positive false) (anti-hbs-positive true) (anti-hbc-positive true))
    =>
    (printout t crlf"Hasil Prediksi = Cured" crlf)
)

(defrule have-vaccinated
    (and (hbsag-positive false) (anti-hbs-positive true) (anti-hbc-positive false))
    =>
    (printout t crlf"Hasil Prediksi = Vaccinated" crlf)
)

(defrule have-unclear
    (and (hbsag-positive false) (anti-hbs-positive false) (anti-hbc-positive true))
    =>
    (printout t crlf"Hasil Prediksi = Unclear (possible resolved)" crlf)
)

(defrule have-healhty
    (and (hbsag-positive false) (anti-hbs-positive false) (anti-hbc-positive false))
    =>
    (printout t crlf"Hasil Prediksi = Healthy not vaccinated or suspicious" crlf)
)
