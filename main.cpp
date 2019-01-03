#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQml/QQmlEngine>
#include <QJsonObject>
#include <QVariantList>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationDomain("github.com/anandmg101");
    app.setApplicationName("Car-Stereo");
    QQmlApplicationEngine engine;

    int defaultMenuItem = 0;
    QVariantList menuItems;
    menuItems << QJsonObject {{"source","qrc:/qml/MediaPlayer/MediaPlayerLayout.qml"},{"image","icons/svg/music-note.svg"},{"text","Media player"},{"color","#3F51B5"}}.toVariantMap()
              << QJsonObject {{"source",""},{"image","icons/gear-a.png"},{"text","Settings"},{"color","#2196F3"}}.toVariantMap();

    engine.rootContext()->setContextProperty("menuItems", menuItems);
    engine.rootContext()->setContextProperty("defaultMenuItem", defaultMenuItem);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
