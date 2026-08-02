package com.infralytix.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CaseStudy {

    private String title;
    private String scenario;
    private String outcome;
    private String image;
    private String[] technologies;
    private String industry;
}
