﻿#include "XVideo.h"
#include <QPainter>
#include <QDebug>
#include <QNetworkInterface>
#include "XVideoThread.h"


void XVideo::SetSize(int width, int height)
{
    nWidth = width;
    nHeight = height;
}

XVideo::XVideo():
nHeight(720),
nWidth(1360),
isStop(true)
{
    qDebug()<<"create";
    m_pVedioThread = new XVideoThread();
    connect(m_pVedioThread, &XVideoThread::sig_SendOneFrame, this, &XVideo::slot_GetOneFrame);

    QString file = QString::fromUtf8(":/images/cameraConnect.png");
    default_Frame.load(file,"PNG");
    update();

}

XVideo::~XVideo()
{
    qDebug()<<"distory";
    m_pVedioThread->deleteLater();

}

void XVideo::startVideo(const QString &value)
{
    isStop = false;
    m_pVedioThread->setStrPath(value.toStdString());
    m_pVedioThread->start();
}

void XVideo::stop()
{
    m_pVedioThread->stop();
    isStop = true;
    update();
}

void XVideo::slot_GetOneFrame(QImage *pImg)
{
    if (pImg)
    {
        m_Frame = pImg->copy();
        delete pImg;
        update();
    }
}

void XVideo::paint(QPainter *pPainter)
{
    if(isStop){
        pPainter->drawImage(QRect(0, 0, nWidth, nHeight), default_Frame);
    }else {
        if (!m_Frame.isNull()){
            pPainter->drawImage(QRect(0, 0, nWidth, nHeight), m_Frame);
        }
    }
}

QString XVideo::getStrVideoPath() const
{
    return strVideoPath;
}

void XVideo::setStrVideoPath(const QString &value)
{
    emit strVideoPathChanged(value);
    strVideoPath = value;
    if (m_pVedioThread)
    {
        m_pVedioThread->setStrPath(value.toStdString());
    }
}

int XVideo::getWidth() const
{
    return nWidth;
}

void XVideo::setWidth(int value)
{
    nWidth = value;
    emit widthChanged(value);
}

int XVideo::getHeight() const
{
    return nHeight;
}

void XVideo::setHeight(int value)
{
    nHeight = value;
    emit heightChanged(value);
}
