package com.infralytix.controller;

import com.infralytix.dto.CareerApplicationDto;
import com.infralytix.service.ContactService;
import com.infralytix.service.ContentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class CareersController {

    private final ContentService contentService;
    private final ContactService contactService;

    @GetMapping("/careers")
    public String careers(Model model) {
        model.addAttribute("pageTitle", "Careers");
        model.addAttribute("activePage", "careers");
        model.addAttribute("openings", contentService.getCareerOpenings());
        model.addAttribute("application", new CareerApplicationDto());
        return "careers";
    }

    @PostMapping("/careers/apply")
    public String apply(
            @Valid @ModelAttribute("application") CareerApplicationDto application,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitle", "Careers");
            model.addAttribute("activePage", "careers");
            model.addAttribute("openings", contentService.getCareerOpenings());
            return "careers";
        }

        contactService.submitCareerApplication(application);
        redirectAttributes.addFlashAttribute("successMessage",
                "Thank you! Your application has been submitted successfully.");
        return "redirect:/careers";
    }
}
