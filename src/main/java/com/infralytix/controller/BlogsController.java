package com.infralytix.controller;

import com.infralytix.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class BlogsController {

    private final ContentService contentService;

    @GetMapping("/blogs")
    public String blogs(Model model) {
        model.addAttribute("pageTitle", "Blogs");
        model.addAttribute("activePage", "blogs");
        model.addAttribute("blogs", contentService.getLatestBlogs());
        return "blogs";
    }
}
