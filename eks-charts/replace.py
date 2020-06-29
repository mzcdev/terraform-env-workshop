#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import json


def get_charts(chart):
    # print("load_charts : {}".format(chart))

    txt = os.popen("helm search hub '{}' -o json".format(chart)).read()

    return json.loads(txt)


def replace():
    filepath = "00-variable.tf.json"

    if os.path.exists(filepath):
        # print("filepath : {}".format(filepath))

        doc = None

        with open(filepath, "r") as file:
            doc = json.load(file)

            for k in doc["variable"]:
                chart = doc["variable"][k]["description"].split("/")

                old_ver = doc["variable"][k]["default"]
                new_ver = ""

                charts = get_charts(chart[1])

                for o in charts:
                    # print(o["url"], o["version"])

                    url = "https://hub.helm.sh/charts/{}/{}".format(chart[0], chart[1])

                    if o["url"] == url:
                        new_ver = o["version"]

                # replace
                if new_ver != "":
                    if new_ver != old_ver:
                        print(
                            "{}/{} : {} -> {}".format(
                                chart[0], chart[1], old_ver, new_ver
                            )
                        )
                    else:
                        print("{}/{} : {}".format(chart[0], chart[1], old_ver))

                    doc["variable"][k]["default"] = new_ver

        if doc != None:
            with open(filepath, "w") as file:
                json.dump(doc, file, sort_keys=True, indent=2)


def main():
    replace()


if __name__ == "__main__":
    main()
