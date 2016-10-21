/*
 * Copyright (c) 2015 OpenALPR Technology, Inc.
 * Open source Automated License Plate Recognition [http://www.openalpr.com]
 *
 * This file is part of OpenALPR.
 *
 * OpenALPR is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License
 * version 3 as published by the Free Software Foundation
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef OPENALPR_DETECTORMORPH_H
#define	OPENALPR_DETECTORMORPH_H

#include <stdio.h>
#include <iostream>
#include <vector>

#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/core/core.hpp"
#include "opencv2/ml/ml.hpp"

#include "detector.h"

namespace alpr {

  class DetectorMorph : public Detector {
  public:
    DetectorMorph(Config* config, PreWarp* prewarp);
    virtual ~DetectorMorph();

    std::vector<cv::Rect> find_plates(cv::Mat frame, cv::Size min_plate_size, cv::Size max_plate_size);

  private:
    bool CheckSizes(cv::RotatedRect& mr);
    bool ValidateCharAspect(cv::Rect& r0, float idealAspect);
    
  };

}

#endif	/* OPENALPR_DETECTORMORPH_H */

