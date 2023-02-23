# Colorfy

A real-time background color changer using Flutter Web and [Dart Frog](https://dartfrog.vgv.dev). Test the [live app here](https://colorfy-web.web.app/#/).

## Project Description

Colorfy is a real-time background color changer that allows multiple clients to connect and go on a color war with each other. The application is built using Flutter Web, a framework for building web applications using Dart programming language, and Dart Frog, a backend solution provided by [VeryGoodVentures](https://verygood.ventures/?utm_source=dartfrog&utm_medium=docs&utm_campaign=df) Flutter Software Company.

The Colorfy application allows clients to connect to a TCP server managed by the Dart Frog backend. Clients are assigned ranks based on the order they connect, with the first client receiving rank 0, the second client receiving rank 1, and so on. Clients can then send commands to the server to change the background color of all clients with a lower rank than themselves. The Dart Frog server manages these requests and ensures that higher-ranked clients cannot execute commands sent by lower-ranked clients.

One of the challenges faced during the development of this project was implementing the rank upgrade between clients. The challenge lied in how to know that a client had disconnected and availing this rank for the clients to determine whether an upgrade was necessary. This was overcome by using [broadcast bloc package](https://pub.dev/packages/broadcast_bloc) to provide real-time notifications and synchronization of data between the server and all clients involved.

To use the application, launch a web browser and access it [here](https://colorfy-web.web.app/#/). The application is deployed on Firebase for ease of use.

## How to install and run the project
1. Clone the repository using git clone 
```bash
git clone https://github.com/root458/negelected-client
```
2. Ensure that Flutter is installed on your system. If not, follow the instructions [here](https://docs.flutter.dev/get-started/install).
3. Navigate to the project directory. Run:
```bash
flutter pub get
```
```bash
flutter run --flavor development --target lib/main_development.dart -d chrome
```
This runs the application with the localhost server. Ensure you have installed and started the server locally by following the instructions [here](https://github.com/root458/ds-server), for this to work.

Run against the production server using this command.
```bash
flutter run --flavor production --target lib/main_production.dart -d chrome
```

This launches the application for you.

## How to use the project
1. The app automatically connects to the server when it launches.
2. Tap any of the colors and watch the change. The server delivers your rank after your first color change.
3. Watch the changes on your friends' instances which have lower ranks.
If the client is the highest-ranked client, the background color will change for all clients with a lower rank than themselves.
If a higher-ranked client disconnects, the server will notify all clients with a lower rank, allowing them to upgrade their rank by pressing the "Upgrade" button. Watch out for this notification when a button appears and vigorously shakes.

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
