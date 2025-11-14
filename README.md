# RNCP DevOps System Administrator
[Evaluation en cours de Formation ECF10](RNCP_DEVOPS-ECF10.pdf)

#  📊 EXPLOITER UNE SOLUTION DE SUPERVISION


## 📚 CONSIGNES

- L’objectif ici sera le monitoring de deux serveurs Linux à l’aide de Nagios.
- VirtualBox sera utilisé pour la réalisation des maquettes.
- Pensez à mettre ces maquettes en accès par pont pour y avoir accès depuis votre pc.
- Les serveurs Linux n’auront pas besoin d’interface graphique.

L’entreprise Y possède 2 serveurs que l’on souhaite monitorer :
- Un serveur Ubuntu 22.10 avec le rôle Apache/PHP + MySQL d’installé et hébergeant le logiciel de ticketing de l’entreprise (GLPI)
- Un Windows server 2022 avec le rôle AD-DNS-DHCP de l’entreprise

## 🎯 OBJECTIFS

- Il faudra ainsi créer ces deux serveurs puis créer et configurer notre serveur de supervision ( sous Debian 11)
- L’objectif ensuite sera de définir tous les indicateurs de supervision Nagios pour notre serveur GLPI ainsi que pour le serveur hébergeant Nagios.
- Pour les sondes, il faudra utiliser NRPE et/ou Nsclient ++.
- Vous pouvez ensuite simuler un incident de production (ex : ping KO) et le traiter par la suite.
- Il faudra ensuite installer sur le serveur Nagios l’outil RSyslog afin de centraliser les logs.

## 🎯 LIVRABLES

- Vous fournirez dans les livrables la capture d’écran du tableau de bord Nagios avec la liste des indicateurs surveillés en visu.
- Les fichiers de configuration RSyslog
- Le tableau des indicateurs suivis pour chaque serveur

