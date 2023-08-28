import sys
from sqlalchemy import create_engine, MetaData, Table
from sqlalchemy import insert,select,delete,update
#from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import SQLAlchemyError


##############################################
#from sqlalchemy.sql import select,insert
##############################################


DB_HOST = '127.0.0.1'
DB_PORT ='5000'
DB_USERS = 'root'
DB_PASSWORD = 'admskadi'
DB_DATABASE = 'myresi'
DB_DRIVE = 'mariadb'
DB_URI= f'mariadb+mariadbconnector://{DB_USERS}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_DATABASE}'

DB_ENGINE=engine=create_engine(DB_URI,echo=True, echo_pool="debug")

metadata=MetaData()

Utilisateurs = Table('Utilisateurs', metadata,autoload_with=engine)
GestionnairesImmobiliers = Table('GestionnairesImmobiliers', metadata,autoload_with=engine)
AgencesImmobilières = Table('AgencesImmobilières', metadata,autoload_with=engine)
GestionnaireAgence = Table('GestionnaireAgence',metadata,autoload_with=engine)
Immeuble = Table('Immeuble', metadata,autoload_with=engine)
Appartements = Table('Appartements', metadata, autoload_with=engine)
Résidences = Table('Résidences', metadata,autoload_with=engine)
Locataires = Table('Locataires', metadata,autoload_with=engine)
DemandesRénovation = Table('DemandesRénovation', metadata,autoload_with=engine)
Paiements = Table('Paiements', metadata,autoload_with=engine)
DemandesRénovation = Table('DemandesRénovation', metadata,autoload_with=engine)
Administrateur = Table('Administrateur', metadata,autoload_with=engine)





