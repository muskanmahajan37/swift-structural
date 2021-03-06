// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Benchmark
import Foundation
import StructuralCore
import StructuralExamples

let myEquatableBenchmarks = BenchmarkSuite(name: "MyEquatable") { suite in

    suite.benchmark("Point1") {
        boolSink = p1_1 == p1_2
    }

    suite.benchmark("Point2") {
        boolSink = p2_1 == p2_2
    }

    suite.benchmark("Point3") {
        boolSink = p3_1 == p3_2
    }

    suite.benchmark("Point4") {
        boolSink = p4_1 == p4_2
    }

    suite.benchmark("Point5") {
        boolSink = p5_1 == p5_2
    }

    suite.benchmark("Point6") {
        boolSink = p6_1 == p6_2
    }

    suite.benchmark("Point7") {
        boolSink = p7_1 == p7_2
    }

    suite.benchmark("Point8") {
        boolSink = p8_1 == p8_2
    }

    suite.benchmark("Point9") {
        boolSink = p9_1 == p9_2
    }

    suite.benchmark("Point10") {
        boolSink = p10_1 == p10_2
    }

    suite.benchmark("Point11") {
        boolSink = p11_1 == p11_2
    }

    suite.benchmark("Point12") {
        boolSink = p12_1 == p12_2
    }

    suite.benchmark("Point13") {
        boolSink = p13_1 == p13_2
    }

    suite.benchmark("Point14") {
        boolSink = p14_1 == p14_2
    }

    suite.benchmark("Point15") {
        boolSink = p15_1 == p15_2
    }

    suite.benchmark("Point16") {
        boolSink = p16_1 == p16_2
    }

    suite.benchmark("BinaryTree") {
        boolSink = tree1 == tree2
    }

    suite.benchmark("Color") {
        boolSink = color1 == color2
    }

    suite.benchmark("ASCII") {
        boolSink = ascii1 == ascii2
    }
}
