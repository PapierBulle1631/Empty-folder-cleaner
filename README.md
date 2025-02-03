
# Supprimer les Dossiers Vides - Script PowerShell

Ce script PowerShell fournit une interface graphique simple permettant aux utilisateurs de trouver et de supprimer les dossiers vides dans un dossier source spécifié. Le script génère également un fichier journal dans le dossier de destination sélectionné pour suivre la suppression des dossiers vides.

## Fonctionnalités
- **Interface graphique** : Construite avec Windows Forms pour offrir une interface graphique conviviale.
- **Sélection du dossier source** : Parcourez et sélectionnez le dossier à scanner pour les dossiers vides.
- **Sélection du dossier de destination** : Choisissez un dossier pour enregistrer le rapport du journal.
- **Suppression des dossiers vides** : Supprime automatiquement tous les dossiers vides trouvés dans le dossier source et ses sous-dossiers.
- **Fichier journal** : Enregistre toutes les actions, y compris les chemins des dossiers supprimés et les erreurs rencontrées pendant le processus.
- **Retour en temps réel** : Fournit un retour en temps réel dans la zone de texte du journal pendant le processus de scan et de suppression.

## Prérequis
- Système d'exploitation Windows
- PowerShell (version 5.0 ou supérieure)

## Installation
Pour utiliser ce script, il vous suffit de télécharger le fichier `.ps1` et de l'exécuter dans PowerShell.

### Étapes pour exécuter le script :
1. Ouvrez PowerShell avec les droits d'administrateur.
2. Téléchargez le script dans un dossier de votre machine locale.
3. Naviguez vers ce dossier dans PowerShell.
4. Exécutez le script avec la commande suivante :
   ```powershell
   .\SupprimerLesDossiersVides.ps1
   ```

## Aperçu du Script
1. **Éléments de l'interface graphique** :
   - Le script crée un formulaire avec des étiquettes, des zones de texte, des boutons et une zone de sortie du journal.
   - Vous pouvez sélectionner le dossier source à scanner pour les dossiers vides à l'aide du bouton "Parcourir".
   - Vous pouvez choisir le dossier où le rapport sera enregistré à l'aide d'un autre bouton "Parcourir".
   - Une fois les chemins définis, cliquez sur le bouton "Lancer la recherche" pour démarrer le processus.

2. **Fichier journal** :
   - Le fichier journal sera enregistré dans le dossier de destination que vous spécifiez et suivra chaque dossier scanné, les dossiers vides trouvés et toute erreur survenue pendant le processus de suppression.

3. **Gestion des erreurs** :
   - Si aucun dossier source ou de destination valide n'est sélectionné, un message d'erreur s'affichera.
   - Les erreurs lors de la suppression des dossiers vides sont enregistrées, permettant ainsi à l'utilisateur de suivre tout problème.

## Comment Utiliser
1. **Dossier Source** : Cliquez sur le bouton "Parcourir" à côté de "Source" pour sélectionner le dossier à scanner.
2. **Dossier de Destination** : Cliquez sur le bouton "Parcourir" à côté de "Rapport" pour choisir où le rapport sera enregistré.
3. **Démarrer l'analyse** : Cliquez sur le bouton "Lancer la recherche" pour commencer à scanner et supprimer les dossiers vides.
4. **Consulter le journal** : Au fur et à mesure que le processus se déroule, le journal affichera la progression, les dossiers trouvés et supprimés, ainsi que les erreurs rencontrées.

## Exemple de sortie du journal
```txt
+------------------------------------------------------------------
|
|   Nouveau dossier scanné : C:\Utilisateurs\Exemple\Documents
|
+------------------------------------------------------------------
Dossier vide trouvé et supprimé : C:\Utilisateurs\Exemple\Documents\DossierVide1
Dossier vide trouvé et supprimé : C:\Utilisateurs\Exemple\Documents\DossierVide2
Le processus de suppression des dossiers vides est terminé.
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$   Fin du nettoyage du dossier C:\Utilisateurs\Exemple\Documents
$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```

## Contributions
N'hésitez pas à contribuer en soumettant des problèmes ou des demandes de tirage pour améliorer les fonctionnalités ou ajouter de nouvelles fonctionnalités !

## Licence
Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

## Remerciements
- Ce script utilise **System.Windows.Forms** pour l'interface graphique et repose sur l'environnement de script PowerShell.

---

**Avertissement** : Utilisez ce script avec précaution, surtout lorsqu'il s'agit de supprimer des fichiers ou des dossiers. Il est recommandé de tester d'abord dans un environnement contrôlé.
