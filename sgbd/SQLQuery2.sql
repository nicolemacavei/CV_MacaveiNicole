CREATE TABLE Geschaft(GeschaftId int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
						NameGeschaft varchar(50), Adresse varchar(50))

CREATE TABLE Angestellter(AngestellterId int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
							NameAngestellter varchar(50), Geburtstag date, GeschaftId int,
							FOREIGN KEY (GeschaftId) REFERENCES Geschaft(GeschaftId))

CREATE TABLE Kunde(KundenId int NOT NULL IDENTITY(1,1), PRIMARY KEY (KundenId),		
					NameKunde varchar(50), GeschaftId int,
					FOREIGN KEY (GeschaftId) REFERENCES Geschaft(GeschaftId))

CREATE TABLE Verteiler(VerteilerId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
						NameVerteiler varchar(50))

CREATE TABLE Produkt(ProduktId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
						NameProdukt varchar(50),GeschaftId int,
						FOREIGN KEY (GeschaftId) REFERENCES Geschaft(GeschaftId))

CREATE TABLE Angebot(AngebotId int NOT NULL IDENTITY(1,1) PRIMARY KEY,
						Prozent int)

CREATE TABLE Angebot_nach_Produkte(AngebotId int, ProduktId int, ExpirationDate date
									PRIMARY KEY (AngebotId,ProduktId), FOREIGN KEY (AngebotId) REFERENCES Angebot(AngebotId),
									FOREIGN KEY (ProduktId) REFERENCES Produkt(ProduktId))

CREATE TABLE Verteiler_nach_Geschaft(GeschaftId int, VerteilerId int,PRIMARY KEY (VerteilerId,GeschaftId), 
									FOREIGN KEY (GeschaftId) REFERENCES Geschaft(GeschaftId),
									FOREIGN KEY (VerteilerId) REFERENCES Verteiler(VerteilerId))

CREATE TABLE Kategorie(KategorieId int NOT NULL IDENTITY(1,1) PRIMARY KEY ,		
					NameKategorie varchar(50), GeschaftId int,
					FOREIGN KEY (GeschaftId) REFERENCES Geschaft(GeschaftId))

CREATE TABLE Review(ReviewId int NOT NULL IDENTITY(1,1) PRIMARY KEY,		
					KundenId int,FOREIGN KEY (KundenId) REFERENCES Kunde(KundenId),
					ReviewDate date, GeschaftId int,
					FOREIGN KEY (GeschaftId) REFERENCES Geschaft(GeschaftId))


