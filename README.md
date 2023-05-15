# Clock In

**ClockIn** ist eine Gruppenarbeit im Rahmen der SWE-Vorlesung an der DHBW Stuttgart. Dies ist das Repository mit dem
aktuellsten Stand des Codes.

## Geplante Funktionen

Clock In ist eine Software zur Erfassung, Visualisierung und Verwaltung von Arbeitzeit.

- **Nutzer** können ihre Arbeitszeit im Homeoffice oder in der Arbeit tracken und sehen in einem Dashboard wichtige
  Informationen bezüglich ihres Arbeitsrhytmus. Zudem werden Überstunden automatisch getrackt und es bestehen Funktionen
  zur Beantragung von Urlaub.
- **Manager** können mehrere zugeordnete Nutzer verwalten, Anträge bearbeitet und Übersichten der Arbeitszeiten erstellen.
- **Administratoren** können neue Nutzerkonten erstellen und diese löschen oder sperren und Zugriffsrechte von Managern verwalten. Dies geschieht direkt über die Datenbank. So können Nutzer übersichtlich und durch Nutzung gängiger Tools eingepflegt werden.

## Testing
Eine einfache Möglichkeit, die App zu testen, besteht darin, die dafür bereitgestellten Demo-Accounts zu nutzen. Diese enthalten vorgefertigte Werte wie beispielsweise 8 Stunden aufgezeichnete Zeit pro Tag, da das Generieren von Daten eine Herausforderung darstellt - Sie müssten die App für mehrere Stunden laufen lassen. Durch die Verwendung dieser Demo-Accounts wird zudem das aufwändige Backend-Setup überflüssig.
- Demo-Account Nutzer: user:user (email:passwort)
- Demo-Account Manager: admin:admin (email:passwort)

### Testing mit Backend:
- Installieren von Docker
- Im Terminal: docker-compose up
- In Datenbank einen Benutzer anlegen (z.B test@test.com, etc)
- Netzwerk-Einstellungen so verändern, dass andere Geräte (Handy mit App) auf Backend-Server (localhost) zugreifen können.
- Starten der App -> in angelegten Benutzer einloggen (z.B test@test.com)

## Umsetzung

Die Umsetzung des Projektes wird mithilfe von Jira
getrackt. [Link zum Agile Board](https://swezwei.atlassian.net/jira/software/projects/SZ/boards/1)

## Tools
Frontend: Flutter

Backend: C#
