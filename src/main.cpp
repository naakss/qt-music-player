/***************************************************************************/
/*! \file       main.cpp
 * \brief       main
 *
 * \copyright   Copyright (c) 2023 Sagar Gurudas Nayak
 * \copyright   MIT License
 *
 * \remark    Email: sagargnayak26@gmail.com
 ***************************************************************************/

#include "Application.h"

int main(int argc, char *argv[])
{
    Application app(argc, argv);

    if (!app.init()) {
        return -1;
    }

    return app.exec();
}
