<?php

namespace Modules\Frontend\Http\Controllers\API;

use App\Helpers\InstituteHelper;
use App\Http\Controllers\Controller;
use App\Mail\InstituteOnboardingMail;
use Carbon\Carbon;
use Exception;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use Illuminate\Database\QueryException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Modules\Academic\Models\Event;
use Modules\Academic\Models\Notice;
use Modules\Academic\Models\Teacher;
use Modules\Authentication\Models\Branch;
use Modules\Authentication\Models\Institute;
use Modules\Authentication\Models\InstituteImageSAASSetting;
use Modules\Authentication\Models\InstituteImageSetting;
use Modules\Authentication\Models\Plan;
use Modules\Authentication\Models\Subscription;
use Modules\Authentication\Models\SubscriptionItem;
use Modules\Authentication\Models\User;
use Modules\Elearning\Models\Course;
use Modules\Elearning\Models\CourseCategory;
use Modules\Frontend\Http\Requests\Contact\ContactStoreRequest;
use Modules\Frontend\Http\Requests\Onboarding\OnboardingStoreRequest;
use Modules\Frontend\Models\AboutUs;
use Modules\Frontend\Models\AcademicImage;
use Modules\Frontend\Models\Banner;
use Modules\Frontend\Models\Contact;
use Modules\Frontend\Models\FaqQuestion;
use Modules\Frontend\Models\MobileAppSection;
use Modules\Frontend\Models\Onboarding;
use Modules\Frontend\Models\OurHistory;
use Modules\Frontend\Models\Policy;
use Modules\Frontend\Models\ReadyToJoinUs;
use Modules\Frontend\Models\Testimonial;
use Modules\Frontend\Models\Theme;
use Modules\Frontend\Models\WhyChooseUs;
use Spatie\Permission\Models\Role;

class FrontendController extends Controller
{
    public function banners(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Banner::where('institute_id', $instituteId)
                ->whereNull('deleted_at')
                ->get();

            return $this->responseSuccess(
                $data,
                'Banners has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function aboutUs(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = AboutUs::where('institute_id', $instituteId)->where('status', 1)->whereNull('deleted_at')->first();

            return $this->responseSuccess(
                $data,
                'AboutUs has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function academicImages(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data['pageTitle'] = 'Academic Images';
            $data['academicImages'] = AcademicImage::where('institute_id', $instituteId)->whereNull('deleted_at')->get();

            return $this->responseSuccess(
                $data,
                'AcademicImages has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function whyChooseUs(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = WhyChooseUs::select(
                'id',
                'institute_id',
                'branch_id',
                'title',
                'description',
                'icon',
                'created_at',
            )
                ->where('institute_id', $instituteId)
                ->whereNull('deleted_at')
                ->get();

            return $this->responseSuccess(
                $data,
                'WhyChooseUs has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function readyToJoinUs(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = ReadyToJoinUs::select(
                'id',
                'institute_id',
                'branch_id',
                'title',
                'description',
                'icon',
                'button_name',
                'button_link',
                'created_at',
            )
                ->where('institute_id', $instituteId)
                ->whereNull('deleted_at')
                ->get();

            return $this->responseSuccess(
                $data,
                'ReadyToJoinUs has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function teachers(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Teacher::with('user')->select(
                'id',
                'institute_id',
                'branch_id',
                'user_id',
                'department_id',
                'name',
                'designation',
                'sl',
                'status',
                'created_at',
            )
                ->where('institute_id', $instituteId)
                ->whereNull('deleted_at')
                ->get();

            return $this->responseSuccess(
                $data,
                'Teachers has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function events(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Event::select(
                'id',
                'institute_id',
                'branch_id',
                'start_date',
                'end_date',
                'name',
                'image',
                'details',
                'location',
                'created_at',
            )
                ->where('institute_id', $instituteId)
                ->get();

            return $this->responseSuccess(
                $data,
                'Events has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function notices(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Notice::select('id', 'title', 'notice', 'date', 'image', 'created_by')->with('userType')
                ->where('institute_id', $instituteId)
                ->whereNull('deleted_at')
                ->limit(5)
                ->get();

            return $this->responseSuccess(
                $data,
                'Notices has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function faq(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = FaqQuestion::where('institute_id', $instituteId)
                ->select('id', 'institute_id', 'question', 'answer')
                ->whereNull('deleted_at')
                ->get();

            return $this->responseSuccess(
                $data,
                'Faqs has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function privacyPolicy(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Policy::where('institute_id', $instituteId)->select('id', 'institute_id', 'type', 'description')->whereType(1)->whereNull('deleted_at')->first();

            return $this->responseSuccess(
                $data,
                'Privacy Policy has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function cookiePolicy(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Policy::where('institute_id', $instituteId)->select('id', 'institute_id', 'type', 'description')->whereType(2)->whereNull('deleted_at')->first();

            return $this->responseSuccess(
                $data,
                'Cookie Policy has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function termConditions(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Policy::where('institute_id', $instituteId)->select('id', 'institute_id', 'type', 'description')->whereType(3)->whereNull('deleted_at')->first();

            return $this->responseSuccess(
                $data,
                'Terms & Conditions has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function ourHistory(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = OurHistory::where('institute_id', $instituteId)
                ->select(
                    'institute_id',
                    'year',
                    'title',
                    'descriptions',
                    'status',
                    'created_by',
                )
                ->whereNull('deleted_at')
                ->first();

            return $this->responseSuccess(
                $data,
                'Our History has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function testimonials(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = Testimonial::select(
                'id',
                'institute_id',
                'branch_id',
                'user_id',
                'description',
                'status',
            )
                ->with('user')
                ->where('institute_id', $instituteId)
                ->whereNull('deleted_at')
                ->get();

            return $this->responseSuccess(
                $data,
                'Testimonials has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function mobileAppSections(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = MobileAppSection::select(
                'id',
                'institute_id',
                'branch_id',
                'title',
                'heading',
                'description',
                'image',
                'feature_one',
                'feature_two',
                'feature_three',
                'play_store_link',
                'app_store_link',
            )
                ->where('institute_id', $instituteId)
                ->whereNull('deleted_at')
                ->get();

            return $this->responseSuccess(
                $data,
                'MobileAppSections has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function settings(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $allowedKeys = [
                'school_name',
                'site_title',
                'phone',
                'email',
                'language',
                'google_map',
                'address',
                'timezone',
                'academic_year',
                'currency_symbol',
                'logo',
                'copyright_text',
                'facebook_link',
                'google_plus_link',
                'youtube_link',
                'whats_app_link',
                'twitter_link',
                'eiin_code',
                'header_notice',
                'exam_result_status',
                'admission_display_status',
                'guidance',
                'academic_office',
                'website_link',
                'primary_color',
                'secondary_color',
                'primary_container_color',
                'dark_primary_color',
                'dark_secondary_color',
                'dark_container_color',
                'text_color',
                'dark_text_color',
                'sidebar_selected_bg_color',
                'sidebar_selected_text_color',
            ];

            $settings = DB::table('settings')
                ->whereIn('name', $allowedKeys)
                ->where('institute_id', $instituteId)
                ->pluck('value', 'name');

            return $this->responseSuccess(
                $settings,
                'Settings have been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function courses(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $query = Course::where('institute_id', $instituteId);

            // Search by category_id (optional)
            if ($request->has('course_category_id') && ! empty($request->course_category_id)) {
                $query->where('course_category_id', $request->course_category_id);
            }

            // Search by title (optional)
            if ($request->has('title') && ! empty($request->title)) {
                $query->where('title', 'like', '%'.$request->title.'%');
            }

            // Search by price range (optional)
            if ($request->has('min_price') && ! empty($request->min_price)) {
                $query->where('price', '>=', $request->min_price);
            }
            if ($request->has('max_price') && ! empty($request->max_price)) {
                $query->where('price', '<=', $request->max_price);
            }

            // Search by status (optional)
            if ($request->has('status') && ! empty($request->status)) {
                $query->where('status', $request->status);
            }

            // Pagination logic: Default to 10 items per page
            $perPage = $request->get('perPage', 10); // Default to 10 if not provided
            $data = $query->paginate($perPage);

            return $this->responseSuccess(
                $data,
                'Courses fetched successfully with the applied filters.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function categoryWiseCourses(Request $request): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data['pageTitle'] = 'Course Categories and Courses';
            // Get the first 5 CourseCategories and load the related courses
            $data['courseCategories'] = CourseCategory::where('institute_id', $instituteId)
                ->whereHas('courses') // Ensures that only categories with courses are fetched
                ->with('courses')
                ->select('id', 'institute_id', 'name', 'slug', 'status', 'created_at')
                ->limit(5)->get();

            return $this->responseSuccess(
                $data,
                'Course Categories and Courses has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function courseDetails(Request $request, string $slug): JsonResponse
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        $course = Course::with([
            'courseChapters.contents' => function ($query) {
                $query->orderBy('serial');
            },
            'courseChapters.contents.contentable',
            'zoomMeetings',
            'courseFaqs',
        ])->where('slug', $slug)
            ->where('institute_id', $instituteId)
            ->first();
        if (! $course) {
            return $this->responseError([], 'Course not found', 404);
        }

        $transformed = [
            'course_id' => $course->id,
            'course_title' => $course->title,
            'course_slug' => $course->slug,
            'course_description' => $course->description,
            'course_image' => $course->image,
            'course_video_type' => $course->video_type,
            'course_video_url' => $course->video_url,
            'course_embedded_url' => $course->embedded_url,
            'course_uploaded_video_path' => $course->uploaded_video_path,
            'course_status' => $course->status,
            'course_publish_date' => $course->publish_date,
            'course_type' => $course->type,
            'course_payment_type' => $course->payment_type,
            'course_invoice_title' => $course->invoice_title,
            'course_regular_price' => $course->regular_price,
            'course_offer_price' => $course->offer_price,
            'course_repeat_count' => $course->repeat_count,
            'course_fake_enrolled_students' => $course->fake_enrolled_students + $course->total_enrolled,
            'course_total_classes' => $course->total_classes,
            'course_total_notes' => $course->total_notes,
            'course_total_exams' => $course->total_exams,
            'course_payment_duration' => $course->payment_duration,
            'course_total_cycles' => $course->total_cycles,
            'course_is_infinity' => $course->is_infinity,
            'course_is_auto_generate_invoice' => $course->is_auto_generate_invoice,
            'course_class_routine_image' => $course->class_routine_image,
            'course_meta_description' => $course->meta_description,
            'course_meta_keywords' => $course->meta_keywords,
            'course_total_view' => $course->total_view,
            'course_total_enrolled' => $course->total_enrolled,
            'course_created_by' => $course->created_by,
            'zoom_meetings' => $course->zoomMeetings->map(function ($meeting) {
                return [
                    'meeting_id' => $meeting->id,
                    'topic' => $meeting->topic,
                    'start_time' => $meeting->start_time,
                    'duration' => $meeting->duration,
                    'password' => $meeting->password,
                    'join_url' => $meeting->join_url,
                ];
            }),
            'course_faqs' => $course->courseFaqs,
            'course_chapters' => $course->courseChapters->map(function ($chapter) {
                return [
                    'chapter_id' => $chapter->id,
                    'chapter_title' => $chapter->title,
                    'chapter_description' => $chapter->description,
                    'chapter_priority' => $chapter->priority,
                    'contents' => $chapter->contents->map(function ($content) {
                        $contentable = $content->contentable;

                        // Basic fields
                        $entry = [
                            'content_id' => $content->id,
                            'type' => $content->type,
                            'type_id' => $content->type_id,
                            'serial' => $content->serial,
                            'title' => $contentable->title ?? null,
                        ];

                        switch ($content->type) {
                            case 'lesson':
                                $entry['thumbnail_image'] = $contentable->thumbnail_image ?? null;
                                $entry['video_type'] = $contentable->video_type ?? null;
                                $entry['video_url'] = $contentable->video_url ?? null;
                                $entry['embedded_url'] = $contentable->embedded_url ?? null;
                                $entry['uploaded_video_path'] = $contentable->uploaded_video_path ?? null;
                                $entry['attachments'] = $contentable->attachments ?? null;
                                $entry['document_file'] = $contentable->document_file ?? null;
                                $entry['description'] = null;
                                $entry['is_scheduled'] = $contentable->is_scheduled ?? null;
                                $entry['scheduled_at'] = $contentable->scheduled_at ?? null;
                                $entry['playback_hours'] = $contentable->playback_hours ?? null;
                                $entry['playback_minutes'] = $contentable->playback_minutes ?? null;
                                $entry['playback_seconds'] = $contentable->playback_seconds ?? null;
                                $entry['visibility'] = $contentable->visibility ?? null;
                                $entry['password'] = $contentable->password ?? null;
                                $entry['priority'] = $contentable->priority ?? null;
                                $entry['created_by'] = $contentable->created_by ?? null;
                                $entry['status'] = $contentable->status ?? null;
                                break;

                            case 'quiz':
                                $entry['title'] = $contentable->title;
                                $entry['description'] = $contentable->description;
                                $entry['guidelines'] = $contentable->guidelines;
                                $entry['show_description_on_course_page'] = $contentable->show_description_on_course_page;
                                $entry['quiz_type'] = $contentable->type;
                                $entry['question_ids'] = $contentable->question_ids;
                                $entry['start_time'] = $contentable->start_time;
                                $entry['end_time'] = $contentable->end_time;
                                $entry['has_time_limit'] = $contentable->has_time_limit;
                                $entry['time_limit_value'] = $contentable->time_limit_value;
                                $entry['time_limit_unit'] = $contentable->time_limit_unit;
                                $entry['on_expiry'] = $contentable->on_expiry;
                                $entry['marks_per_question'] = $contentable->marks_per_question;
                                $entry['negative_marks_per_wrong_answer'] = $contentable->negative_marks_per_wrong_answer;
                                $entry['pass_mark'] = $contentable->pass_mark;
                                $entry['attempts_allowed'] = $contentable->attempts_allowed;
                                $entry['enable_negative_marking'] = $contentable->enable_negative_marking;
                                $entry['result_visibility'] = $contentable->result_visibility;
                                $entry['layout_pages'] = $contentable->layout_pages;
                                $entry['shuffle_questions'] = $contentable->shuffle_questions;
                                $entry['shuffle_options'] = $contentable->shuffle_options;
                                $entry['access_type'] = $contentable->access_type;
                                $entry['access_password'] = $contentable->access_password;
                                $entry['status'] = $contentable->status;
                                break;

                            case 'assignment':
                                $entry['deadline'] = $contentable->deadline ?? null;
                                $entry['file'] = $contentable->file ?? null;
                                break;

                            case 'pdf':
                                $entry['file'] = $contentable->file ?? null;
                                break;

                            case 'offline':
                                $entry['description'] = null;
                                break;
                        }

                        return $entry;
                    })
                        ->values()
                        ->keyBy(function ($item, $key) {
                            return (string) $key;
                        }),
                ];
            }),
        ];

        return $this->responseSuccess(
            $transformed,
            'Course has been fetched successfully.'
        );
    }

    private function getInstituteIdFromHeader(Request $request): mixed
    {
        $domain = $request->header('X-Domain'); // Custom header key (Change if needed)
        if (! $domain) {
            return $this->responseError([], 'Domain header is missing.', 400);
        }

        $instituteResponse = InstituteHelper::getInstituteIdByDomain($domain);
        if (! $instituteResponse['status']) {
            return $this->responseError([], $instituteResponse['error'], 404);
        }

        return $instituteResponse['institute_id'];
    }

    public function contactUs(ContactStoreRequest $request): JsonResponse
    {
        try {
            $instituteId = $this->getInstituteIdFromHeader($request);
            if ($instituteId instanceof JsonResponse) {
                return $instituteId;
            }

            // Store Contact
            $contact = Contact::create([
                'email' => $request->email,
                'institute_id' => $instituteId,
            ]);

            return $this->responseSuccess(
                $contact,
                'Contact form submitted successfully.'
            );
        } catch (QueryException $e) {
            return $this->responseError([], 'Duplicate entry for email or phone.');
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function themes(Request $request)
    {
        $themes = Theme::get();

        return $this->responseSuccess(
            $themes,
            'themes get successfully.'
        );
    }

    public function onboarding(OnboardingStoreRequest $request): JsonResponse
    {
        // Define fields to check for duplicates inside the JSON column
        $fieldsToCheck = [
            'institute_name' => 'Institute Name',
            'institute_email' => 'Institute Email',
            'institute_phone' => 'Institute Phone',
            'institute_domain' => 'Institute Domain',
            'user_email' => 'User Email',
            'user_phone' => 'User Phone',
        ];

        // Step 1: Loop through fields and check for duplicates in the collected_data JSON column
        foreach ($fieldsToCheck as $field => $label) {
            $value = $request->$field;
            // Use JSON_EXTRACT and JSON_UNQUOTE for cross-compatibility
            $exists = Onboarding::whereRaw("JSON_UNQUOTE(JSON_EXTRACT(collected_data, '$.{$field}')) = ?", [$value])->exists();

            if ($exists) {
                return $this->responseError([], "Duplicate entry for {$label}.", 422);
            }
        }

        // Step 2: Handle other validation logic and file uploads
        $validated = $request->validated();

        // Handle the institute_logo file upload if it exists
        $instituteLogoPath = null;
        if ($request->hasFile('institute_logo')) {
            $instituteLogoPath = fileUploader('institutes/', 'png', $request->file('institute_logo'));
        }

        // Handle the user_avatar file upload if it exists
        $userAvatarPath = null;
        if ($request->hasFile('user_avatar')) {
            $userAvatarPath = fileUploader('user_avatars/', 'png', $request->file('user_avatar'));
        }

        // Step 3: Save onboarding data
        $onboarding = Onboarding::create([
            'collected_data' => [
                'institute_name' => $validated['institute_name'],
                'institute_email' => $validated['institute_email'],
                'institute_phone' => $validated['institute_phone'],
                'institute_domain' => ($validated['institute_domain'] ?? null) ?: $this->schoolSubdomain($validated['institute_name']),
                'institute_type' => $validated['institute_type'] ?? null,
                'user_name' => $validated['user_name'],
                'user_email' => $validated['user_email'],
                'user_phone' => $validated['user_phone'],
                'curriculum' => $validated['curriculum'] ?? null,
                // Never keep the plain password in the onboarding record.
                'password' => Hash::make($validated['password']),
            ],
            'institute_logo' => $instituteLogoPath,
            'user_avatar' => $userAvatarPath,
            'status' => 'pending',
        ]);

        // Create the new institute
        $institute = Institute::create([
            'name' => $onboarding->collected_data['institute_name'],
            'institute_type' => $onboarding->collected_data['institute_type'],
            'email' => $onboarding->collected_data['institute_email'],
            'phone' => $onboarding->collected_data['institute_phone'],
            'domain' => $onboarding->collected_data['institute_domain'],
            'logo' => $onboarding->institute_logo,
        ]);

        $branch = new Branch;
        $branch->name = 'Main Branch';
        $branch->institute_id = $institute->id;
        $branch->save();

        // Create the associated user
        $user = User::create([
            'institute_id' => $institute->id,
            'branch_id' => $branch->id,
            'name' => $onboarding->collected_data['user_name'],
            'email' => $onboarding->collected_data['user_email'],
            'phone' => $onboarding->collected_data['user_phone'],
            'password' => $onboarding->collected_data['password'],
            'avatar' => $onboarding->user_avatar,
            'role_id' => 2,
            'user_type' => 'System Admin',
        ]);

        if ($user) {
            // The school gets its own copy of the standard roles; its admin is that school's Super Admin.
            $provisioner = app(\App\Services\RoleProvisioner::class);
            $provisioner->ensure($institute->id, $branch->id);
            $role = Role::find($provisioner->roleId($institute->id, $branch->id, 'Super Admin') ?? 2);
            $user->forceFill(['role_id' => $role->id, 'user_type' => 'Super Admin'])->save();
            $user->assignRole($role);
        }

        // Default Settings
        DB::table('settings')->insert([
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'school_name', 'value' => 'Demo Collage'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'site_title', 'value' => 'Demo Title'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'phone', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'email', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'language', 'value' => 'en'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'google_map', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'address', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'on_google_map', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'institute_code', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'timezone', 'value' => 'Asia/Dhaka'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'academic_year', 'value' => '1'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'currency_symbol', 'value' => '$'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'mail_type', 'value' => 'mail'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'logo', 'value' => 'logo.png'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'disabled_website', 'value' => 'no'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'copyright_text', 'value' => '&copy; Copyright 2025. All Rights Reserved by FueDevs LTD'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'exam_result_phone', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'tuition_fee_phone', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'facebook_link', 'value' => 'https://www.facebook.com/'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'google_plus_link', 'value' => 'https://www.google.com/'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'youtube_link', 'value' => 'https://www.youtube.com/'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'whats_app_link', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'twitter_link', 'value' => 'https://www.twitter.com'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'eiin_code', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'sms_gateway', 'value' => 'twilio'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'bulk_sms_api_key', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'bulk_sms_sender_id', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'twilio_sid', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'twilio_token', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'twilio_from_number', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'zoom_account_id', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'zoom_client_key', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'zoom_client_secret', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'header_notice', 'value' => ''],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'exam_result_status', 'value' => 'no'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'admission_display_status', 'value' => 'no'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'tc_amount', 'value' => 00],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'app_version', 'value' => '1.0.0'],
            ['institute_id' => $institute->id, 'branch_id' => $branch->id, 'type' => 'general', 'name' => 'app_url', 'value' => 'drive-link'],
        ]);

        // Curriculum preset chosen at sign-up (CBC, 8-4-4, British, College/TVET).
        if (! empty($validated['curriculum'])) {
            try {
                app(\App\Services\CurriculumService::class)->apply($institute->id, $branch->id, $validated['curriculum']);
            } catch (\Throwable $e) {
                report($e);
            }
        }

        $plan = Plan::findOrFail(1);
        $startDate = Carbon::now();
        // Public sign-up always gets the standard trial; extra days are only granted by the platform admin.
        $endDate = $startDate->copy()->addDays($plan->duration_days);

        $subscription = Subscription::create([
            'institute_id' => (int) $institute->id,
            'plan_id' => $plan->id,
            'start_date' => $startDate,
            'end_date' => $endDate,
            'status' => 'active',
        ]);
        SubscriptionItem::create([
            'subscription_id' => $subscription->id,
            'amount_paid' => 0,
        ]);

        // Domain Config in Vercel.
        $vercelDomainResponse = ($institute->domain && get_saas_option('vercel_token'))
            ? $this->addDomainToVercel($institute->domain)
            : ['success' => true];
        // Optional: Store log or update institute status
        if (! $vercelDomainResponse['success']) {
            Log::warning('Vercel domain add failed', [
                'domain' => $institute->domain,
                'response' => $vercelDomainResponse,
            ]);
        }

        // MAIL Sent
        try {
            // Check basic mail configuration
            if (
                empty(config('mail.mailers.smtp.host')) ||
                empty(config('mail.mailers.smtp.username')) ||
                empty(config('mail.from.address'))
            ) {
                Log::warning('Mail configuration missing. Institute onboarding mail not sent.', [
                    'institute_id' => $institute->id,
                ]);
            } else {
                Mail::to($institute->email)->send(
                    new InstituteOnboardingMail([
                        'institute_name' => $institute->name,
                        'institute_id' => $institute->id,
                        'email' => $institute->email,
                        'password' => $validated['password'],
                        'package_name' => 'Trial Package',
                        'trial_days' => $plan->duration_days,
                        'trial_end_date' => $endDate->format('Y-m-d'),
                        'login_url' => rtrim((string) config('app.frontend_url'), '/').'/sign-in',
                    ])
                );
            }
        } catch (\Throwable $e) {
            // Log error but do not stop execution
            Log::error('Institute onboarding mail failed', [
                'institute_id' => $institute->id,
                'email' => $institute->email,
                'error' => $e->getMessage(),
            ]);
        }
        $accessToken = $user->createToken('app')->accessToken;

        // Return success response
        return $this->responseSuccess(
            [
                'user' => $user,
                'access_token' => $accessToken,
                'school_url' => $institute->domain ? 'https://'.$institute->domain : null,
                'login_url' => rtrim((string) config('app.frontend_url'), '/').'/sign-in',
            ],
            'Onboarding request submitted successfully.'
        );
    }

    /**
     * Each new school gets its own website address, e.g. "st-marys.classcompass.co.ke".
     * Empty when SCHOOL_DOMAIN_SUFFIX is not set (the school adds its own domain later).
     */
    private function schoolSubdomain(string $name): ?string
    {
        $suffix = trim((string) config('app.school_domain_suffix'), '.');
        if ($suffix === '') {
            return null;
        }
        $base = \Illuminate\Support\Str::of($name)->lower()->replaceMatches('/\b(the|school|academy|college|high|primary|secondary|and)\b/', ' ')->slug()->limit(30, '')->trim('-')->value();
        $base = $base !== '' ? $base : \Illuminate\Support\Str::slug($name);
        $base = in_array($base, ['www', 'app', 'api', 'demo', 'admin', 'mail', 'support'], true) || $base === '' ? 'school-'.$base : $base;
        $domain = "{$base}.{$suffix}";
        for ($i = 2; Institute::where('domain', $domain)->exists(); $i++) {
            $domain = "{$base}-{$i}.{$suffix}";
        }

        return $domain;
    }

    public function defaultTheme(Request $request)
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        $institute = Institute::with('theme')
            ->find($instituteId);

        if (! $institute) {
            return $this->responseError([], 'Institute not found', 404);
        }

        return $this->responseSuccess(
            $institute->theme,
            'Default theme retrieved successfully.'
        );
    }

    private function addDomainToVercel($fullDomain)
    {
        $client = new Client;

        $projectId = get_saas_option('vercel_project_id');
        $token = get_saas_option('vercel_token');
        $url = "https://api.vercel.com/v9/projects/{$projectId}/domains";

        try {
            $response = $client->post($url, [
                'headers' => [
                    'Authorization' => 'Bearer '.$token,
                    'Content-Type' => 'application/json',
                ],
                'json' => [
                    'name' => $fullDomain,
                ],
            ]);

            return [
                'success' => true,
                'data' => json_decode($response->getBody(), true),
            ];
        } catch (ClientException $e) {
            return [
                'success' => false,
                'error_type' => 'client',
                'message' => $e->getMessage(),
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'error_type' => 'general',
                'message' => $e->getMessage(),
            ];
        }
    }

    public function instituteImageSAASSetting(Request $request)
    {
        try {
            $data = InstituteImageSAASSetting::first();

            return $this->responseSuccess(
                $data,
                'Institute SAAS Settings Image has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }

    public function instituteImageSetting(Request $request)
    {
        $instituteId = $this->getInstituteIdFromHeader($request);
        if ($instituteId instanceof JsonResponse) {
            return $instituteId;
        }

        try {
            $data = InstituteImageSetting::where('institute_id', $instituteId)->first();

            return $this->responseSuccess(
                $data,
                'Institute Settings Image has been fetched successfully.'
            );
        } catch (Exception $e) {
            return $this->responseError([], $e->getMessage());
        }
    }
}
