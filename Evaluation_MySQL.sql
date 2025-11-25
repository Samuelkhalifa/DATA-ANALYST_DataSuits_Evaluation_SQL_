--  EVALUATION FINALE DU MODULE 2 SQL


CREATE DATABASE Samsung_DB;
USE Samsung_DB;


-- Exercice 1 :
SELECT *
FROM
	clients_samsung
WHERE
	Age >= 30
    AND Revenu_Annuel BETWEEN 40000 AND 70000
    AND Date_Inscription > '2018-01-01'
    AND Score_Fidelite > 5;


-- Exercice 2 :
SELECT *
FROM
	ventes_samsung
WHERE
	Montant_Total > 1000
    AND Score_Satisfaction < 3
    AND Canal_Achat = 'En ligne'
    AND Delai_Livraison_Jours > 20;


-- Exercice 3 :
SELECT 
	DISTINCT Pays_Vente
FROM
	ventes_samsung;
    

-- Exercice 4 :
SELECT
	Canal_Achat,
    ROUND(AVG(Score_Satisfaction),2) AS Score_moyen_satisfaction,
    COUNT(ID_Vente) AS Nbr_total_ventes
FROM
	ventes_samsung
GROUP BY
	Canal_Achat;


-- Exercice 5 :
SELECT 
	pr.ID_Produit, 
    pr.Prix,
    COUNT(ve.ID_Vente) AS Nbr_total_ventes
FROM
	produits_samsung AS pr
    LEFT JOIN ventes_samsung AS ve 
		ON pr.ID_Produit = ve.ID_Produit
GROUP BY
	pr.ID_Produit,
    pr.Prix;


-- Exercice 6 :
SELECT 
	Pays,
	ROUND(AVG(Age)) AS Age_moyen_client,
    MAX(Revenu_Annuel) AS Revenu_annuel_max
FROM
	clients_samsung
GROUP BY
	Pays;


-- Exercice 7 :
SELECT
	Methode_Expedition,
    MIN(Delai_Livraison_Jours) AS Delai_minimum_livraison,
    ROUND(AVG(Score_Satisfaction),2) AS Score_moyen_satisfaction
FROM
	ventes_samsung
GROUP BY
	Methode_Expedition;


-- Exercice 8 :
SELECT
	CASE
		WHEN Score_Fidelite < 5 THEN 'Faible'
        WHEN Score_Fidelite BETWEEN 5 AND 7 THEN 'Moyen'
        ELSE 'Elevé'
	END AS Niveau_score_fidelite,
    COUNT(ID_Client) AS Nbr_clients
FROM
	clients_samsung
GROUP BY
	Niveau_score_fidelite;


-- Exercice 9 :
SELECT
	pr.ID_Produit, 
    SUM(ve.Montant_Total) AS Montant_total_ventes
FROM
	produits_samsung AS pr
    LEFT JOIN ventes_samsung AS ve
		ON pr.ID_Produit = ve.ID_Produit
GROUP BY
	pr.ID_Produit
HAVING 
	Montant_total_ventes > 15000;


-- Exercice 10 :
SELECT
	Pays_Vente,
    COUNT(ID_Vente) AS Nbr_total_ventes
FROM
	ventes_samsung
GROUP BY
	Pays_Vente
HAVING
	Nbr_total_ventes > 400;


-- Exercice 11 :
SELECT
	DATE_FORMAT(Date_Vente, '%m') AS N°Mois,
    DATE_FORMAT(Date_Vente, '%M') AS Mois,
    DATE_FORMAT(Date_Vente, '%Y') AS Annee,
    SUM(Montant_Total) AS Montant_total_ventes
FROM
	ventes_samsung
GROUP BY
	N°Mois,
	Mois,
    Annee;
    

-- Exercice 12 :
SELECT
	CASE
		WHEN DATE_FORMAT(Date_Vente, '%W') IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Semaine'
	END AS Type_jour,
    COUNT(ID_Vente) AS Nbr_total_ventes
FROM
	ventes_samsung
GROUP BY
	Type_jour;


-- Exercice 13 :
SELECT
	CASE
		WHEN DATE_FORMAT(Date_Vente, '%M') IN ('January', 'February', 'March', 'April') THEN "Début d'année"
        WHEN DATE_FORMAT(Date_Vente, '%M') IN ('May', 'June', 'July', 'August') THEN "Milieu d'année"
        ELSE "Fin d'année"
	END AS Periode,
    SUM(Montant_Total) AS Montant_total_ventes
FROM
	ventes_samsung
GROUP BY
	Periode;


-- Exercice 14 :
SELECT
	ID_Client,
    Pays,
    ROUND(AVG(Score_Fidelite),2) AS Score_moyen_fidelite
FROM
	clients_samsung
WHERE
	Pays IN ('France', 'Allemagne')
GROUP BY
	ID_Client,
    Pays
HAVING
    Score_moyen_fidelite > 7;


-- Exercice 15 :
SELECT *,
	CASE
		WHEN Age < 35 AND Revenu_Annuel > 50000 THEN 'Jeune à Revenu Elevé'
        WHEN Age < 35 AND (Revenu_Annuel BETWEEN 30000 AND 50000) THEN 'Jeune à Revenu Moyen'
        WHEN Age < 35 AND Revenu_Annuel < 30000 THEN 'Jeune à Revenu Faible'
		WHEN Age >= 35 AND Revenu_Annuel > 50000 THEN 'Senior à Revenu Elevé'
        WHEN Age >= 35 AND (Revenu_Annuel BETWEEN 30000 AND 50000) THEN 'Senior à Revenu Moyen'
        WHEN Age >= 35 AND Revenu_Annuel < 30000 THEN 'Senior à Revenu Faible'
	END AS Segment_Client
FROM
	clients_samsung;


-- Exercice 16 :
SELECT
	DATE_FORMAT(Date_Vente, '%m') AS N°Mois,
	DATE_FORMAT(Date_Vente, '%M') AS Mois,
    SUM(Quantite_Vendue) AS Quantite_totale_vendue
FROM
	ventes_samsung
GROUP BY
	N°Mois,
    Mois;


-- Exercice 17 :
SELECT
	pr.Gamme,
    ve.Pays_Vente,
    COUNT(ve.ID_Vente) AS Nbr_ventes,
    SUM(ve.Montant_Total) AS Montant_total_ventes
FROM
	ventes_samsung AS ve
    LEFT JOIN produits_samsung AS pr
		ON ve.ID_Produit = pr.ID_Produit
GROUP BY
	pr.Gamme,
    ve.Pays_Vente;
	

-- Exercice 18 :
SELECT
	pr.Gamme,
    ve.Canal_Achat,
    COUNT(ID_Vente) AS Nbr_ventes,
    SUM(Quantite_Vendue) AS Quantite_totale_vendue,
    SUM(Montant_Total) AS Montant_total_ventes,
    ROUND(AVG(Score_Satisfaction),2) AS Satisfaction_moyenne
FROM
	produits_samsung AS pr
    INNER JOIN ventes_samsung AS ve
		ON pr.ID_Produit = ve.ID_Produit
GROUP BY
	pr.Gamme,
    ve.Canal_Achat
ORDER BY
	pr.Gamme,
    ve.Canal_Achat;
    

-- Exercice 19 :
SELECT
	DATE_FORMAT(ve.Date_Vente, '%m') AS N°Mois,
    DATE_FORMAT(ve.Date_Vente, '%M') AS Mois,
    DATE_FORMAT(ve.Date_Vente, '%Y') AS Annee,
    Gamme,
    COUNT(ve.ID_Vente) AS Nbr_ventes,
    SUM(ve.Quantite_vendue * pr.Prix) AS Chiffre_affaires_total,
    SUM(ve.Quantite_vendue) AS Quantite_totale_vendue,
    ROUND(AVG(Delai_Livraison_Jours)) AS Delai_moyen_livraison
FROM
	ventes_samsung AS ve
    LEFT JOIN produits_samsung AS pr
		ON ve.ID_Produit = pr.ID_produit
GROUP BY
	N°Mois,
	Mois,
    Annee,
    Gamme;


-- Exercice 20 :
SELECT
	cl.Canal_Prefere,
    cl.Preference_Produit,
    COUNT(DISTINCT cl.ID_Client) AS Nbr_Clients_Uniques,
    ROUND(AVG(cl.Score_Fidelite),2) AS Fidelite_moyenne,
    SUM(Quantite_vendue * Prix) AS Montant_total_depense,
    CASE
		WHEN ROUND(AVG(cl.Score_Fidelite),2) > 6 AND SUM(Quantite_vendue * Prix) > 200000 THEN 'VIP'
        ELSE 'Standard'
	END AS Classe_client
FROM
	clients_samsung AS cl
    LEFT JOIN ventes_samsung AS ve
		ON cl.ID_Client = ve.ID_Client
	LEFT JOIN produits_samsung AS pr
		ON ve.ID_Produit = pr.ID_Produit
WHERE
	cl.Date_Inscription > '2018-01-01'
GROUP BY
	Canal_Prefere,
    Preference_Produit;
